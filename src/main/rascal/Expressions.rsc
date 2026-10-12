module Expressions

import ParseTree;

// Espacios, tabulaciones y saltos de línea
layout Whitespace = [\ \t\n\r]* !>> [\ \t\n\r];

// Números enteros
lexical IntLiteral = [0-9]+;

// Multiplicación, división y módulo
syntax MulExpr =
    number: IntLiteral
  | multiplication: MulExpr "*" IntLiteral
  | division: MulExpr "/" IntLiteral
  | modulo: MulExpr "%" IntLiteral
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