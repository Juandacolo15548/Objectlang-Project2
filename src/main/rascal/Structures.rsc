module Structures

layout Espacios = [\ \t\n\r]* !>> [\ \t\n\r];
lexical TypeIdentifier = [A-Z] [a-zA-Z0-9_]* !>> [a-zA-Z0-9_];
lexical Identifier = ([a-z] [a-zA-Z0-9_]* !>> [a-zA-Z0-9_]) \ PalabrasReservadas;

syntax Expr = idExpr: Identifier id;
syntax Type 
  = simpleType: TypeIdentifier name
  | genericType: TypeIdentifier name "[" {Type ","}+ "]" typeArgs;


start syntax Module = moduleDef: ObjectDef* objects MainMethod main;

syntax MainMethod = mainMethod: "method" "main" Block block;

syntax ObjectDef  
  = objectDef: "object" TypeIdentifier name 
               GenericParams? generics 
               Extends? superType 
               ConstructorArgs? constructorArgs;

syntax ConstructorArgs 
  = constructorArgsDef: "(" {ConstructorParam ","}* params ")";

syntax Extends 
  = extendsDef: "extends" Type type;

syntax GenericParams 
  = genericParams: "[" {GenericParam ","}+ params "]";

syntax Variance 
  = covariant: "+"
  | contravariant: "-" ;

syntax Mutability 
  = valMut: "val"
  | varMut: "var" ;




syntax GenericParam 
  = genericParam: Variance? variance TypeIdentifier typeId;

syntax ConstructorParam 
  = constructorParam: Mutability mutability Identifier name ":" Type paramType;


syntax Block = block: "{" Expr* statements "}";

keyword PalabrasReservadas = "object" | "extends" | "val" | "var" | "method" | "main";

