module StructureTests

import ParseTree;
import ObjectlangAST;
import StructureConverter;
import Node;
import Exception;

// Mismo estilo de limpieza de tu compañero
Program cleanAST(Program p) {
    return unsetRec(p);
}

// Función auxiliar para pruebas negativas
bool rejectsProgram(str input) {
    try {
        convertProgram(input);
        return false;
    } catch ParseError(_): {
        return true;
    }
}

// ==========================================
// PRUEBAS NEGATIVAS (ParseErrors esperados)
// ==========================================

test bool testRejectMissingParens() = 
    rejectsProgram("method main { val myPuppy = new Puppy }");

test bool testRejectObjectAnimal() = 
    rejectsProgram("objectAnimal method main { }");

test bool testRejectMethodMain() = 
    rejectsProgram("methodmain { }");

// ==========================================
// PRUEBAS POSITIVAS (Aserciones exactas de AST)
// ==========================================

test bool testObjectFoo() =
    moduleProgram(
        [objectDeclaration("Foo", [], [], [])],
        exprStmt(blockExpression(blockNode([]))) 
    ) == cleanAST(convertProgram("object Foo() method main { }"));

test bool testPrintX() =
    moduleProgram(
        [],
        exprStmt(blockExpression(blockNode([
            exprStmt(call(identifier("print"), [identifier("x")]))
        ])))
    ) == cleanAST(convertProgram("method main { print(x) }"));

test bool testDosLlamadas() =
    moduleProgram(
        [],
        exprStmt(blockExpression(blockNode([
            exprStmt(call(identifier("f"), [identifier("x")])),
            exprStmt(call(identifier("g"), [identifier("y")]))
        ])))
    ) == cleanAST(convertProgram("method main { f(x)\n g(y) }"));

test bool testNewDog() =
    moduleProgram(
        [],
        exprStmt(blockExpression(blockNode([
            valDecl("d", [], newObject(simpleType("Dog"), [], []))
        ])))
    ) == cleanAST(convertProgram("method main { val d = new Dog() }"));

test bool testNewPuppy() =
    moduleProgram(
        [],
        exprStmt(blockExpression(blockNode([
            valDecl("p", [], newObject(simpleType("Puppy"), [], []))
        ])))
    ) == cleanAST(convertProgram("method main { val p = new Puppy() }"));

test bool testForStmt() =
    moduleProgram(
        [],
        exprStmt(blockExpression(blockNode([
            forStmt(
                forBinding(idPattern("x"), "\<-", identifier("xs")),
                exprStmt(call(identifier("print"), [identifier("x")]))
            )
        ])))
    ) == cleanAST(convertProgram("method main { for (x \<- xs) print(x) }"));
