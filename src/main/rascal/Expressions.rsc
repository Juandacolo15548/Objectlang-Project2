module Expressions

import ParseTree;
extend Lexical;

// Espacios, tabulaciones y saltos de línea
layout Whitespace = [\ \t\n\r]* !>> [\ \t\n\r];

syntax Primary =
    number: IntLiteral
  | identifier: Identifier
  | grouped: "(" Expr ")"
  ;

syntax Postfix =
    Primary PostfixOp*
  ;

syntax UnaryExpr =
    Postfix
  | unaryMinus: "-" UnaryExpr
  | unaryNeg: "neg" UnaryExpr
  ;

syntax PowExpr =
    UnaryExpr
  | power: UnaryExpr "**" PowExpr
  ;

// Multiplicación, división y módulo
syntax MulExpr =
    PowExpr
  | left (
        multiplication: MulExpr "*" MulExpr
      | division: MulExpr "/" MulExpr
      | modulo: MulExpr "%" MulExpr
    )
  ;

// Suma y resta
syntax AddExpr =
    MulExpr
  | addition: AddExpr "+" MulExpr
  | subtraction: AddExpr "-" MulExpr
  ;

// Punto de entrada de la gramática
start syntax Expr = AddExpr;

// Interpolación de expresiones
syntax ExprInterpolation =
    "${" Expr "}";

// Punto de entrada temporal para pruebas
start syntax ExprInterpolationTest =
    ExprInterpolation;

syntax ArgList =
    Expr ("," Expr)*;

start syntax ArgListTest =
    ArgList;

syntax PostfixOp =
    "." Identifier
  | "(" ArgList? ")"
  ;

start syntax PostfixOpTest = PostfixOp;
