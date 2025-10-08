#include "Parser.h"
#include <string>
#include <fstream>
#include <sstream>
#include <stdexcept>

static std::string readFileContent(const std::string& filename) {
    std::ifstream formulaFile(filename);
    if (!formulaFile) {
        throw std::runtime_error("Could not open file: " + filename);
    }
    std::stringstream buffer;
    buffer << formulaFile.rdbuf();
    return buffer.str();
}

Parser::Parser(const std::string& filename)  : lexer(readFileContent(filename)) {
    currentToken = lexer.getNextToken();
}

void Parser::consume(TokenType expectedType) {
    if (currentToken.type == expectedType) {
        currentToken = lexer.getNextToken();
    } else {
        throw std::runtime_error("Unexpected token. Expected: " + std::to_string(expectedType) + 
                                 ", Got: " + currentToken.value);
    }
}

std::shared_ptr<Formula> Parser::parseFormula() {
    consume(TOKEN_BEGIN);
    std::shared_ptr<Formula> formula = parseIff();
    consume(TOKEN_END);
    consume(TOKEN_EOF);
    return formula;
}

std::shared_ptr<Formula> Parser::parseRest() {
    // parenthesised expression
    if (currentToken.type == TOKEN_LPAREN) {
        consume(TOKEN_LPAREN);
        std::shared_ptr<Formula> inside = parseIff();
        consume(TOKEN_RPAREN);
        return inside;
    }

    if (currentToken.type == TOKEN_LBRACKET) {
        consume(TOKEN_LBRACKET);
        if (currentToken.type != TOKEN_MODALITY) {
            throw std::runtime_error("Expected modality after '[' but got: " + currentToken.value);
        }
        std::string modality_str = currentToken.value;
        consume(TOKEN_MODALITY);
        consume(TOKEN_RBRACKET);

        std::shared_ptr<Formula> rest = parseRest();

        if (modality_str.size() < 2 || modality_str[0] != 'r') {
            throw std::runtime_error("Bad modality token: " + modality_str);
        }
        int modIndex = std::stoi(modality_str.substr(1));
        return Box::create(modIndex, 1, rest);
    }

    if (currentToken.type == TOKEN_LT) {
        consume(TOKEN_LT);
        if (currentToken.type != TOKEN_MODALITY) {
            throw std::runtime_error("Expected modality after '<' but got: " + currentToken.value);
        }
        std::string modality_str = currentToken.value;
        consume(TOKEN_MODALITY);
        consume(TOKEN_GT);

        std::shared_ptr<Formula> rest = parseRest();
        if (modality_str.size() < 2 || modality_str[0] != 'r') {
            throw std::runtime_error("Bad modality token: " + modality_str);
        }
        int modIndex = std::stoi(modality_str.substr(1));
        return Diamond::create(modIndex, 1, rest);
    }

    // negation
    if (currentToken.type == TOKEN_NOT) {
        consume(TOKEN_NOT);
        return Not::create(parseRest());
    }

    // constants
    if (currentToken.type == TOKEN_TRUE) {
        consume(TOKEN_TRUE);
        return True::create();
    }
    if (currentToken.type == TOKEN_FALSE) {
        consume(TOKEN_FALSE);
        return False::create();
    }

    // atom
    if (currentToken.type == TOKEN_ATOM) {
        std::string name = currentToken.value;
        consume(TOKEN_ATOM);
        return Atom::create(name);
    }

    throw std::runtime_error("Unexpected token in parseRest: " + currentToken.value);
}

std::shared_ptr<Formula> Parser::parseAnd() {
    std::shared_ptr<Formula> left = parseRest();
    while (currentToken.type == TOKEN_AND) {
        consume(TOKEN_AND);
        std::shared_ptr<Formula> right = parseRest();

        formula_set andSet;
        if (left->getType() == FAnd) {
            andSet.insert(dynamic_cast<And*>(left.get())->getSubformulas().begin(),
                          dynamic_cast<And*>(left.get())->getSubformulas().end());
        } else {
            andSet.insert(left);
        }
        if (right->getType() == FAnd) {
            andSet.insert(dynamic_cast<And*>(right.get())->getSubformulas().begin(),
                          dynamic_cast<And*>(right.get())->getSubformulas().end());
        } else {
            andSet.insert(right);
        }
        left = And::create(andSet);
    }
    return left;
}

std::shared_ptr<Formula> Parser::parseOr() {
    std::shared_ptr<Formula> left = parseAnd();
    while (currentToken.type == TOKEN_OR) {
        consume(TOKEN_OR);
        std::shared_ptr<Formula> right = parseAnd();
        formula_set orSet;
        if (left->getType() == FOr) {
            orSet.insert(dynamic_cast<Or*>(left.get())->getSubformulas().begin(),
                         dynamic_cast<Or*>(left.get())->getSubformulas().end());
        } else {
            orSet.insert(left);
        }
        if (right->getType() == FOr) {
            orSet.insert(dynamic_cast<Or*>(right.get())->getSubformulas().begin(),
                         dynamic_cast<Or*>(right.get())->getSubformulas().end());
        } else {
            orSet.insert(right);
        }
        left = Or::create(orSet);
    }
    return left;
}

std::shared_ptr<Formula> Parser::parseImp() {
    std::shared_ptr<Formula> left = parseOr();
    if (currentToken.type == TOKEN_IMP) {
        consume(TOKEN_IMP);
        std::shared_ptr<Formula> right = parseImp();
        return Or::create({Not::create(left), right});
    }
    return left;
}

std::shared_ptr<Formula> Parser::parseIff() {
    std::shared_ptr<Formula> left = parseImp();
    if (currentToken.type == TOKEN_IFF) {
        consume(TOKEN_IFF);
        std::shared_ptr<Formula> right = parseIff();
        std::shared_ptr<Formula> left_implies_right = Or::create({Not::create(left), right});
        std::shared_ptr<Formula> right_implies_left = Or::create({Not::create(right), left});
        formula_set conj;
        conj.insert(left_implies_right);
        conj.insert(right_implies_left);
        return And::create(conj);
    }
    return left;
}
