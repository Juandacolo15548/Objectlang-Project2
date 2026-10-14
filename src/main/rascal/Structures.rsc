module Structures

extend Expressions;

// Extensión de Primary para conectar con las expresiones de Juan David
syntax Primary = blockExpression: Block block| newObject: "new" Type type "(" ArgList? args ")" ClassBody? body ;

// ===== TUS REGLAS DEFINITIVAS =====

syntax ModuleItem 
  = objectItem: ObjectDef objectDef
  | methodItem: MethodAssign methodAssign ;

start syntax Module 
  = moduleDef: ModuleItem* items MainMethod main;

syntax MainMethod 
  = mainMethod: "method" [a-zA-Z0-9_] !<< "main" Block block;

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

syntax MethodAssign 
  = methodAssign: TypeIdentifier targetType "." Identifier name "=" MethodDef methodDef;

syntax MethodDef 
  = methodDef: "method" "(" {MethodParam ","}* params ")" ReturnType? returnType Block? body;

syntax MethodParam 
  = methodParam: Identifier name ":" Type paramType;

syntax ReturnType 
  = returnTypeDef: ":" Type type;

syntax ClassBody 
  = classBody: "{" OverrideDef+ overrides "}";

syntax OverrideDef 
  = overrideDef: "override" Identifier name "(" {MethodParam ","}* params ")" ":" Type returnType "=" Block body;

syntax Block = block: "{" Stmt* statements "}";

syntax Stmt 
  = valStmt: ValDecl valDecl
  | varStmt: VarDecl varDecl
  | assignmentStmt: Assignment assignment
  | forStmt: ForStmt forStmt
  | exprStmt: Expr expr ;

syntax ValDecl 
  = valDecl: "val" Identifier name TypeAnnotation? typeAnn "=" Expr expr;

syntax VarDecl 
  = varDecl: "var" Identifier name TypeAnnotation? typeAnn "=" Expr expr;

syntax TypeAnnotation 
  = typeAnnDef: ":" Type type;

syntax Assignment 
  = assignStmt: Expr target "=" Expr expr; // Ajustado de Postfix a Expr según el nivel

syntax ForStmt 
  = forStmt: "for" "(" ForBinding binding ")" Stmt body ;

syntax ForBinding 
  = forBinding: Pattern pattern ForOp op Expr expr ;

syntax ForOp 
  = arrowOp: "\<-" 
  | inOp: "in" ;

syntax Pattern 
  = idPattern: Identifier id
  | tuplePattern: "(" Identifier head "," {Identifier ","}+ tail ")" ;

syntax Type 
  = simpleType: TypeIdentifier name
  | genericType: TypeIdentifier name "[" {Type ","}+ "]" typeArgs;