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
