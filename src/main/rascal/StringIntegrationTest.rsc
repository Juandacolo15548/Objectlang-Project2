module StringIntegrationTest

import ParseTree;
import ObjectlangAST;

extend Expressions;

start syntax FullStringTest =
    stringLiteral: "\"" StringItems "\"";

Expression convertString(str input) {
    tree = parse(#start[FullStringTest], input);

    items = tree.top.args[2].args[0].args;

    list[StringPart] parts = [
        implode(#StringPart, item)
        | item <- items
    ];

    return stringLiteral(parts);
}
