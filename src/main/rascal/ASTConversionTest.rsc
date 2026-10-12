module ASTConversionTest

import ParseTree;
import ObjectlangAST;

layout Whitespace = [\ \t\n\r]*;

lexical IntegerLiteral = [0-9]+;

start syntax CalcExpr
    = number: IntegerLiteral
    | bracket "(" CalcExpr ")"
    > left multiplication: CalcExpr "*" CalcExpr
    > left addition: CalcExpr "+" CalcExpr
    ;

Expression convert(str input) {
    tree = parse(#CalcExpr, input);
    return implode(#Expression, tree);
}
