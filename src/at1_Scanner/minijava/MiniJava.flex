package at1_Scanner.minijava;

import java_cup.runtime.Symbol;

%%

%class MiniJavaScanner
%public
%final
%cup
%function next_token

%line
%column
%eofval{
    return new Symbol(Sym.EOF.ordinal(), yyline, yycolumn);
%eofval}

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
Comment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
LineComment = "//" .* {LineTerminator}?
Identifier = [a-zA-Z] [a-zA-Z0-9_]*
IntegerLiteral = 0 | [1-9] [0-9]*

%%

<YYINITIAL> {
    {WhiteSpace}  { /* Nao faz nada */ }
    {Comment}     { /* Nao faz nada */ }
    {LineComment} { /* Nao faz nada */ }

    "boolean"             { return symbol(Sym.BOOLEAN.ordinal()); }
    "class"               { return symbol(Sym.CLASS_DECL.ordinal()); }
    "extends"             { return symbol(Sym.EXTENDS.ordinal()); }
    "public"              { return symbol(Sym.PUBLIC.ordinal()); }
    "static"              { return symbol(Sym.STATIC.ordinal()); }
    "void"                { return symbol(Sym.VOID.ordinal()); }
    "main"                { return symbol(Sym.MAIN.ordinal()); }
    "String"              { return symbol(Sym.STRING.ordinal()); }
    "return"              { return symbol(Sym.RETURN.ordinal()); }
    "int"                 { return symbol(Sym.INT.ordinal()); }
    "if"                  { return symbol(Sym.IF.ordinal()); }
    "else"                { return symbol(Sym.ELSE.ordinal()); }
    "while"               { return symbol(Sym.WHILE.ordinal()); }
    "System.out.println"  { return symbol(Sym.SYSTEM_OUT_PRINTLN.ordinal()); }
    "length"              { return symbol(Sym.LENGTH.ordinal()); }
    "true"                { return symbol(Sym.TRUE.ordinal()); }
    "false"               { return symbol(Sym.FALSE.ordinal()); }
    "this"                { return symbol(Sym.THIS.ordinal()); }
    "new"                 { return symbol(Sym.NEW.ordinal()); }
    "null"                { return symbol(Sym.NULL.ordinal()); }
    
    "("                   { return symbol(Sym.LPAREN.ordinal()); }
    ")"                   { return symbol(Sym.RPAREN.ordinal()); }
    "["                   { return symbol(Sym.LBRACK.ordinal()); }
    "]"                   { return symbol(Sym.RBRACK.ordinal()); }
    "{"                   { return symbol(Sym.LBRACE.ordinal()); }
    "}"                   { return symbol(Sym.RBRACE.ordinal()); }
    ";"                   { return symbol(Sym.SEMICOLON.ordinal()); }
    "."                   { return symbol(Sym.DOT.ordinal()); }
    ","                   { return symbol(Sym.COMMA.ordinal()); }
    "="                   { return symbol(Sym.ASSIGN.ordinal()); }
    "<"                   { return symbol(Sym.LT.ordinal()); }
    "=="                  { return symbol(Sym.EQ.ordinal()); }
    "!="                  { return symbol(Sym.NEQ.ordinal()); }
    "+"                   { return symbol(Sym.PLUS.ordinal()); }
    "-"                   { return symbol(Sym.MINUS.ordinal()); }
    "*"                   { return symbol(Sym.MULT.ordinal()); }
    "/"                   { return symbol(Sym.DIV.ordinal()); }
    "&&"                  { return symbol(Sym.AND.ordinal()); }
    "!"                   { return symbol(Sym.NOT.ordinal()); }

    {IntegerLiteral}      { return symbol(Sym.INTEGER_LITERAL.ordinal(), Integer.parseInt(yytext())); }
    {Identifier}          { return symbol(Sym.IDENTIFIER.ordinal(), yytext()); }
    
    .                     { 
                            System.err.println("Erro Léxico: Caractere inesperado '" + yytext() + "' na linha " + (yyline + 1) + ", coluna " + (yycolumn + 1));
                            return symbol(Sym.ERROR.ordinal()); 
                          }
}