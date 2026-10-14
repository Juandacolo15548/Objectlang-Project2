module Desambiguar

import Structures;
import ParseTree;
import String;

bool esAmbiguo(Tree t) = /amb(_) := t;

bool empiezaMal(Tree sentencia) {
  str texto = "<sentencia>";
  return startsWith(texto, "(") || startsWith(texto, "-");
}

bool lecturaInvalida(Tree lectura) {
  if (amb(_) := lectura) return false;
  if (appl(Production p, list[Tree] hijos) := lectura) {
    if (label(_, sort("Stmt")) := p.def && empiezaMal(lectura)) return true;
    for (Tree h <- hijos) {
      if (lecturaInvalida(h)) return true;
    }
  }
  return false;
}

Tree elegir(Tree t) {
  if (amb(set[Tree] alts) := t) {
    for (Tree a <- alts, !lecturaInvalida(a)) return elegir(a);
    throw "Ninguna lectura válida";
  }
  return t;
}
