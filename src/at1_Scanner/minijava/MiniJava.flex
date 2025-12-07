package at1_Scanner.minijava;

import java_cup.runtime.*;

%%

%class MiniJavaScanner
%public
%final
%cup
%function next_token
%line
%column
%unicode

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
    {WhiteSpace}  { /* ignorar */ }
    {Comment}     { /* ignorar */ }
    {LineComment} { /* ignorar */ }

    "class"               { return symbol(MiniJavaSym.CLASS_DECL); }
    "public"              { return symbol(MiniJavaSym.PUBLIC); }
    "static"              { return symbol(MiniJavaSym.STATIC); }
    "void"                { return symbol(MiniJavaSym.VOID); }
    "main"                { return symbol(MiniJavaSym.MAIN); }
    "String"              { return symbol(MiniJavaSym.STRING); }
    
    "("                   { return symbol(MiniJavaSym.LPAREN); }
    ")"                   { return symbol(MiniJavaSym.RPAREN); }
    "["                   { return symbol(MiniJavaSym.LBRACK); }
    "]"                   { return symbol(MiniJavaSym.RBRACK); }
    "{"                   { return symbol(MiniJavaSym.LBRACE); }
    "}"                   { return symbol(MiniJavaSym.RBRACE); }
    ";"                   { return symbol(MiniJavaSym.error); }  // Não definido no parser atual!
    
    "boolean"             { return symbol(MiniJavaSym.error); }
    "int"                 { return symbol(MiniJavaSym.error); }
    "if"                  { return symbol(MiniJavaSym.error); }
    "else"                { return symbol(MiniJavaSym.error); }
    "while"               { return symbol(MiniJavaSym.error); }
    "System.out.println"  { return symbol(MiniJavaSym.error); }
    "length"              { return symbol(MiniJavaSym.error); }
    "true"                { return symbol(MiniJavaSym.error); }
    "false"               { return symbol(MiniJavaSym.error); }
    "this"                { return symbol(MiniJavaSym.error); }
    "new"                 { return symbol(MiniJavaSym.error); }
    "null"                { return symbol(MiniJavaSym.error); }
    "return"              { return symbol(MiniJavaSym.error); }
    
    "="                   { return symbol(MiniJavaSym.error); }
    "<"                   { return symbol(MiniJavaSym.error); }
    "=="                  { return symbol(MiniJavaSym.error); }
    "!="                  { return symbol(MiniJavaSym.error); }
    "+"                   { return symbol(MiniJavaSym.error); }
    "-"                   { return symbol(MiniJavaSym.error); }
    "*"                   { return symbol(MiniJavaSym.error); }
    "/"                   { return symbol(MiniJavaSym.error); }
    "&&"                  { return symbol(MiniJavaSym.error); }
    "!"                   { return symbol(MiniJavaSym.error); }
    "."                   { return symbol(MiniJavaSym.error); }
    ","                   { return symbol(MiniJavaSym.error); }

    {IntegerLiteral}      { return symbol(MiniJavaSym.error); }
    {Identifier}          { return symbol(MiniJavaSym.IDENTIFIER, yytext()); }
    
    .                     { 
                            System.err.println("Erro Léxico: '" + yytext() + "'");
                            return symbol(MiniJavaSym.error);
                          }
}