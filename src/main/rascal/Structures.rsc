module Structures

layout Espacios = [\ \t\n\r]* !>> [\ \t\n\r];
lexical TypeIdentifier = [A-Z] [a-zA-Z0-9_]* !>> [a-zA-Z0-9_];
lexical Identifier = [a-z] [a-zA-Z0-9_]* !>> [a-zA-Z0-9_];
syntax Expr = Identifier;   


start syntax Module = moduleDef: ObjectDef* objects MainMethod main;
syntax MainMethod = mainMethod: "method" "main" Block block;
syntax ObjectDef  = objectDef: "object" TypeIdentifier name ;
syntax Block = block: "{" Expr* statements "}";

