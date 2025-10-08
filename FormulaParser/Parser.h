#ifndef PARSER_H
#define PARSER_H

#include "../Formula/And/And.h"
#include "../Formula/Atom/Atom.h"
#include "../Formula/Box/Box.h"
#include "../Formula/Diamond/Diamond.h"
#include "../Formula/False/False.h"
#include "../Formula/Formula/Formula.h"
#include "../Formula/Not/Not.h"
#include "../Formula/Or/Or.h"
#include "../Formula/True/True.h"
#include "Lexer.h"
#include <assert.h>
#include <fstream>
#include <memory>
#include <stdexcept>
#include <stdio.h>
#include <string>

using namespace std;

class Parser {
private:
  Lexer lexer;
  Token currentToken;

  void consume(TokenType expectedType);

  shared_ptr<Formula> parseIff();
  shared_ptr<Formula> parseImp();
  shared_ptr<Formula> parseOr();
  shared_ptr<Formula> parseAnd();
  shared_ptr<Formula> parseRest();

public:
  Parser(const string& filename);
  shared_ptr<Formula> parseFormula();
};

#endif