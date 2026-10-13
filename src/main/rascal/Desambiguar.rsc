module Desambiguar

import Structures;
import ParseTree;
import String;

// Revisa si el árbol contiene algún nodo de ambigüedad
bool esAmbiguo(Tree t) = /amb(_) := t;

// Comprueba si la representación en texto de la sentencia inicia con '(' o '-'
bool empiezaMal(Tree sentencia) {
  str texto = "<sentencia>";
  return startsWith(texto, "(") || startsWith(texto, "-");
}

// Evalúa si una lectura del bloque contiene alguna sentencia que empiezaMal
bool lecturaInvalida(Tree lectura) {
  if (appl(_, list[Tree] hijos) := lectura) {
    for (Tree h <- hijos) {
      if (appl(Production p, _) := h, /sort("Stmt") := p.def, empiezaMal(h)) {
        return true;
      }
    }
  }
  return false;
}

// Reemplaza los nodos ambiguos seleccionando la alternativa válida
Tree resolver(Tree t) = innermost visit(t) {
  case amb(alts) => a when Tree a <- alts, !lecturaInvalida(a)
};

Tree parsear(str src) {
  Tree t = parse(#start[Module], src, allowAmbiguity=true);
  return esAmbiguo(t) ? resolver(t) : t;
}

