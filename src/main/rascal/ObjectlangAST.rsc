module ObjectlangAST

data Expression
    = number(int literal)
    | addition(Expression left, Expression right)
    | subtraction(Expression left, Expression right)
    | multiplication(Expression left, Expression right)
    | division(Expression left, Expression right)
    | modulo(Expression left, Expression right)
    | stringLiteral(list[StringPart] parts)
    | power(Expression left, Expression right)
    | unaryMinus(Expression operand)
    | unaryNeg(Expression operand)
    | identifier(str name)
    | grouped(Expression inner)
    | memberAccess(Expression target, str name)
    | call(Expression target, list[Expression] arguments)
    | lessThan(Expression left, Expression right)
    | greaterThan(Expression left, Expression right)
    | lessOrEqual(Expression left, Expression right)
    | greaterOrEqual(Expression left, Expression right)
    | notEqual(Expression left, Expression right)
    | equal(Expression left, Expression right)
    | inExpression(Expression element, Expression collection)
    | logicalAnd(Expression left, Expression right)
    | logicalOr(Expression left, Expression right)
    | range(Expression from, Expression to)
    | conditional(Expression condition, Expression thenBranch, Expression elseBranch)
    | typeIdentifier(str name)
    | booleanLiteral(bool booleanValue)
    ;

data StringPart
    = textPart(str content)
    | escapePart(str sequence)
    | identifierInterpolation(str name)
    | expressionInterpolation(Expression expression)
    ;

data Program 
    = moduleProgram(list[Declaration] items, Statement mainMethod);

data Declaration 
    = objectDeclaration(str name, list[GenericParameter] generics, list[TypeNode] superType, list[ConstructorParameter] constructorArgs)
    | methodAssignment(str targetType, str name, Declaration methodDef)
    | methodDefinition(list[MethodParameter] params, list[TypeNode] returnType, list[BlockNode] body);

data Statement 
    = valDecl(str name, list[TypeNode] typeAnn, Expression expr)
    | varDecl(str name, list[TypeNode] typeAnn, Expression expr)
    | assignmentStmt(Expression target, Expression expr)
    | forStmt(Statement binding, Statement body)
    | exprStmt(Expression expr)
    | forBinding(PatternNode pattern, str op, Expression expr);

data BlockNode 
    = blockNode(list[Statement] statements);

data PatternNode 
    = idPattern(str id)
    | tuplePattern(str head, list[str] tail);

data GenericParameter = genericParameter(str variance, str typeId);
data ConstructorParameter = constructorParameter(str mutability, str name, TypeNode \type);
data MethodParameter = methodParameter(str name, TypeNode \type);
data OverrideDefinition = overrideDefinition(str name, list[MethodParameter] params, TypeNode returnType, BlockNode body);

data TypeNode 
    = simpleType(str name)
    | genericType(str name, list[TypeNode] typeArgs);
