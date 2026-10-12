module ObjectlangAST

data Expression
    = number(int literal)
    | addition(Expression left, Expression right)
    | subtraction(Expression left, Expression right)
    | multiplication(Expression left, Expression right)
    | division(Expression left, Expression right)
    | modulo(Expression left, Expression right)
    | stringLiteral(list[StringPart] parts)
    ;

data StringPart
    = textPart(str content)
    | escapePart(str sequence)
    | identifierInterpolation(str name)
    | expressionInterpolation(Expression expression)
    ;
