#include "Lexer.h"
#include <cctype>
#include <string>
#include <algorithm>

Lexer::Lexer(const std::string& input) : input(input), position(0) {}

char Lexer::peek() {
    if (position >= input.length()) {
        return '\0';
    }
    return input[position];
}

void Lexer::advance() {
    position++;
}

void Lexer::skipWhitespace() {
    while (position < input.length() && std::isspace(static_cast<unsigned char>(peek()))) {
        advance();
    }
}

Token Lexer::getNextToken() {
    skipWhitespace();
    if (position >= input.length()) {
        return {TOKEN_EOF, ""};
    }

    // --- multi-character operators MUST be checked before single-character '<' or '-' ---
    if (position + 3 <= input.length() && input.compare(position, 3, "<->") == 0) {
        position += 3;
        return {TOKEN_IFF, "<->"};
    }
    if (position + 2 <= input.length() && input.compare(position, 2, "->") == 0) {
        position += 2;
        return {TOKEN_IMP, "->"};
    }

    char c = peek();

    // Helper lambdas that cast to unsigned char to avoid UB for negative char values
    auto is_alpha = [](char ch){ return std::isalpha(static_cast<unsigned char>(ch)); };
    auto is_alnum = [](char ch){ return std::isalnum(static_cast<unsigned char>(ch)); };
    auto is_digit = [](char ch){ return std::isdigit(static_cast<unsigned char>(ch)); };

    // 1. Handle identifiers (keywords, atoms, modalities)
    if (is_alpha(c)) {
        std::string value;
        while (position < input.length() && is_alnum(peek())) {
            value += peek();
            advance();
        }

        // Keywords
        if (value == "begin") return {TOKEN_BEGIN, value};
        if (value == "end")   return {TOKEN_END, value};
        if (value == "true")  return {TOKEN_TRUE, value};
        if (value == "false") return {TOKEN_FALSE, value};

        // modality like r1, r23 (lowercase r followed by digits)
        if (value.length() > 1 && value[0] == 'r' &&
            std::all_of(value.begin() + 1, value.end(), [&](char ch){ return is_digit(ch); })) {
            return {TOKEN_MODALITY, value};
        }

        // fallback: atom
        return {TOKEN_ATOM, value};
    }

    // 2. Single-character tokens
    if (c == '(') { advance(); return {TOKEN_LPAREN, "("}; }
    if (c == ')') { advance(); return {TOKEN_RPAREN, ")"}; }
    if (c == '[') { advance(); return {TOKEN_LBRACKET, "["}; }
    if (c == ']') { advance(); return {TOKEN_RBRACKET, "]"}; }
    if (c == '<') { advance(); return {TOKEN_LT, "<"}; }
    if (c == '>') { advance(); return {TOKEN_GT, ">"}; }
    if (c == '~') { advance(); return {TOKEN_NOT, "~"}; }
    if (c == '&') { advance(); return {TOKEN_AND, "&"}; }
    if (c == '|') { advance(); return {TOKEN_OR, "|"}; }

    // Unknown / invalid single character
    std::string bad(1, c);
    advance();
    return {TOKEN_INVALID, bad};
}

Token Lexer::peekNextToken() {
    size_t savedPos = position;
    Token t = getNextToken();
    position = savedPos;
    return t;
}
