package at1_Scanner.minijava;

/*
 * 
 * Define e centralizar todos os tipos de tokens (símbolos) 
 * que o analisador léxico (scanner) irá reconhecer.
 */

public enum Sym {
  BOOLEAN, CLASS_DECL, EXTENDS, PUBLIC, STATIC, VOID, MAIN, STRING, RETURN, INT,
  IF, ELSE, WHILE, SYSTEM_OUT_PRINTLN, LENGTH, TRUE, FALSE, THIS, NEW, NULL,
  LPAREN, RPAREN, LBRACK, RBRACK, LBRACE, RBRACE, SEMICOLON, DOT, COMMA,
  ASSIGN, LT, EQ, NEQ, PLUS, MINUS, MULT, DIV, AND, NOT,
  IDENTIFIER, INTEGER_LITERAL,
  EOF, ERROR
}