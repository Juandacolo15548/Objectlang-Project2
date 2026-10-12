module Lexical

// Palabras reservadas de Objectlang
keyword Keywords =
    "val" | "var"
  | "method" | "main"
  | "object" | "extends" | "override"
  | "if" | "then" | "else"
  | "for" | "in"
  | "new"
  | "true" | "false"
  | "and" | "or" | "neg"
  ;

// Identificadores
lexical Identifier =
    ([a-z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]) \ Keywords;

// Literales enteros
lexical IntLiteral = [0-9]+;

// Literales booleanos
syntax BoolLiteral = "true" | "false";

// Reglas temporales de prueba
start syntax IntegerTest = IntLiteral;
start syntax BooleanTest = BoolLiteral;

lexical SimpleStringChar = ![\"\\$];

lexical EscapeChar =
    "\\\""
  | "\\$"
  | "\\\\"
  | "\\n"
  | "\\t"
  | "\\r"
  ;

lexical SimpleStringLiteral =
    "\"" (SimpleStringChar | EscapeChar)* "\"";

lexical IdentifierInterpolation =
    "$" Identifier;

lexical InterpolatedStringLiteral =
    "\"" (SimpleStringChar | EscapeChar | IdentifierInterpolation)* "\"";

start syntax InterpolatedStringTest = InterpolatedStringLiteral;

start syntax StringTest = SimpleStringLiteral;

// Regla temporal para pruebas
start syntax IdentifierTest = Identifier;
