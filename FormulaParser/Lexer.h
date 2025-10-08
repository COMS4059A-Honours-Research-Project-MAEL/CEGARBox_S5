#pragma once

#include <string>
#include <vector>
#include <memory>

enum TokenType {
    TOKEN_LPAREN, TOKEN_RPAREN, TOKEN_LBRACKET, TOKEN_RBRACKET,
    TOKEN_LT, TOKEN_GT, TOKEN_NOT, TOKEN_AND, TOKEN_OR, TOKEN_IMP,
    TOKEN_IFF, TOKEN_BEGIN, TOKEN_END, TOKEN_TRUE, TOKEN_FALSE,
    TOKEN_ATOM, TOKEN_MODALITY, TOKEN_EOF, TOKEN_INVALID
};

struct Token {
    TokenType type;
    std::string value;
};

class Lexer {
public:
    Lexer(const std::string& input);
    Token getNextToken();
    Token peekNextToken();

private:
    std::string input;
    size_t position;
    Token currentToken;

    char peek();
    void advance();
    void skipWhitespace();
};
