module Structures

layout Espacios = [\ \t\n\r]* !>> [\ \t\n\r];
lexical TypeIdentifier = [a-zA-Z0-9_] !<< [A-Z] [a-zA-Z0-9_]* !>> [a-zA-Z0-9_];
lexical Identifier = ([a-zA-Z0-9_] !<< [a-z] [a-zA-Z0-9_]* !>> [a-zA-Z0-9_]) \ PalabrasReservadas;

syntax Expr = postfixExpr: Postfix p;
syntax Postfix 
  = idPostfix: Identifier id 
  | fieldPostfix: Postfix obj "." Identifier field
  | newPostfix: NewExpr newExpr
  | blockPostfix: Block block
  | callPostfix: Postfix f "(" {Expr ","}* args ")"
  | parenPostfix: "(" Expr e ")" ;
  
syntax NewExpr = newExprStub: "new" Type type ClassBody? body;

syntax OverrideDef 
  = overrideDef: "override" Identifier name "(" {MethodParam ","}* params ")" ":" Type returnType "=" Block body;

syntax ClassBody 
  = classBody: "{" OverrideDef+ overrides "}";

syntax Type 
  = simpleType: TypeIdentifier name
  | genericType: TypeIdentifier name "[" {Type ","}+ "]" typeArgs;
syntax TypeAnnotation 
  = typeAnnDef: ":" Type type;

syntax ValDecl 
  = valDecl: "val" Identifier name TypeAnnotation? typeAnn "=" Expr expr;
syntax VarDecl 
  = varDecl: "var" Identifier name TypeAnnotation? typeAnn "=" Expr expr;

syntax Assignment 
  = assignStmt: Postfix target "=" Expr expr;

syntax Stmt 
  = valStmt: ValDecl valDecl
  | varStmt: VarDecl varDecl
  | assignmentStmt: Assignment assignment
  | forStmt: ForStmt forStmt
  | exprStmt: Expr expr ;

syntax ModuleItem 
  = objectItem: ObjectDef objectDef
  | methodItem: MethodAssign methodAssign ;

start syntax Module 
  = moduleDef: ModuleItem* items MainMethod main;

syntax MethodAssign 
  = methodAssign: TypeIdentifier targetType "." Identifier name "=" MethodDef methodDef;

syntax MainMethod 
  = mainMethod: "method" [a-zA-Z0-9_] !<< "main" Block block;

syntax ForOp 
  = arrowOp: "\<-" 
  | inOp: "in" ;

syntax Pattern 
  = idPattern: Identifier id
  | tuplePattern: "(" Identifier head "," {Identifier ","}+ tail ")" ;

syntax ForBinding 
  = forBinding: Pattern pattern ForOp op Expr expr ;

syntax ForStmt 
  = forStmt: "for" "(" ForBinding binding ")" Stmt body ;

syntax MethodParam 
  = methodParam: Identifier name ":" Type paramType;

syntax MethodDef 
  = methodDef: "method" "(" {MethodParam ","}* params ")" ReturnType? returnType Block? body;

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


syntax Block = block: "{" Stmt* statements "}";

syntax ReturnType 
  = returnTypeDef: ":" Type type;


keyword PalabrasReservadas 
  = "object" | "extends" | "val" | "var" | "method" | "main" | "override" | "new" | "for" | "in";


