module PostfixConversionTest

extend Expressions;

import ParseTree;
import ObjectlangAST;

Expression convertMemberAccess(str input) {
    tree = parse(#start[Expr], input);

    // Extraemos Postfix de la expresión completa
    postfix = tree.top.args[0].args[0].args[0].args[0].args[0];

    // Convertimos la expresión inicial
    Expression result = implode(#Expression, postfix.args[0]);

    // Obtenemos únicamente las operaciones PostfixOp
    operations = [
        op
        | op <- postfix.args[2].args,
          appl(prod(sort("PostfixOp"), _, _), _) := op
    ];

    // Aplicamos los accesos a miembros de izquierda a derecha
    for (op <- operations) {
        result = memberAccess(
            result,
            yieldMemberName(op)
        );
    }

    return result;
}

str yieldMemberName(Tree op) {
    // En ".edad", args[2] corresponde al Identifier
    return implode(#str, op.args[2]);
}

Expression convertPostfix(Tree postfix) {
    Expression result = implode(#Expression, postfix.args[0]);

    list[Tree] operations = [
        op
        | op <- postfix.args[2].args,
          appl(prod(sort("PostfixOp"), _, _), _) := op
    ];

    for (op <- operations) {

        // Acceso a miembro: .edad
        if (appl(prod(lit("."), _, _), _) := op.args[0]) {
            result = memberAccess(
                result,
                implode(#str, op.args[2])
            );
        }

        // Llamada sin argumentos: ()
        else if (appl(prod(lit("("), _, _), _) := op.args[0]) {
    list[Expression] arguments = [];

    // args[2] contiene ArgList?
    Tree optionalArgs = op.args[2];

    if (!isEmpty(optionalArgs.args)) {
        Tree argList = optionalArgs.args[0];

        // Primer argumento: Expr
        Tree firstExpr = argList.args[0];

        // Por ahora admitimos únicamente un argumento primario.
        Tree firstPostfix =
            firstExpr.args[0].args[0].args[0].args[0].args[0];

        arguments += [implode(#Expression, firstPostfix.args[0])];
    }

    result = call(result, arguments);
    }
    }

    return result;
}

Expression convertCallWithoutArgs(Tree postfix) {
    Expression result = implode(#Expression, postfix.args[0]);

    list[Tree] operations = [
        op
        | op <- postfix.args[2].args,
          appl(prod(sort("PostfixOp"), _, _), _) := op
    ];

    for (op <- operations) {
        if (op.args[0] == op.args[0]) {
            result = call(result, []);
        }
    }

    return result;
}
