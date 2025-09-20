import java_cup.runtime.*;

%%
%class MiniJavaLexer
%unicode
%cup
%line
%column

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

Letter         = [a-zA-Z]
Digit          = [0-9]
Identifier     = {Letter} ({Letter}|{Digit}|_)*
Integer        = {Digit}+

Comment        = "/*" [^*] ~"*/" | "/*" "*"+ "/"

%%

<YYINITIAL> {
    /* Palavras reservadas */
    "class"            { return symbol(sym.CLASS); }
    "public"           { return symbol(sym.PUBLIC); }
    "static"           { return symbol(sym.STATIC); }
    "void"             { return symbol(sym.VOID); }
    "main"             { return symbol(sym.MAIN); }
    "String"           { return symbol(sym.STRING); }
    "int"              { return symbol(sym.INT); }
    "boolean"          { return symbol(sym.BOOLEAN); }
    "if"               { return symbol(sym.IF); }
    "else"             { return symbol(sym.ELSE); }
    "while"            { return symbol(sym.WHILE); }
    "System.out.println" { return symbol(sym.PRINTLN); }
    "true"             { return symbol(sym.TRUE); }
    "false"            { return symbol(sym.FALSE); }
    "this"             { return symbol(sym.THIS); }
    "new"              { return symbol(sym.NEW); }
    "length"           { return symbol(sym.LENGTH); }
    
    /* Operadores e símbolos */
    "="                { return symbol(sym.ASSIGN); }
    "=="               { return symbol(sym.EQ); }
    "!="               { return symbol(sym.NEQ); }
    "<"                { return symbol(sym.LT); }
    ">"                { return symbol(sym.GT); }
    "<="               { return symbol(sym.LE); }
    ">="               { return symbol(sym.GE); }
    "&&"               { return symbol(sym.AND); }
    "||"               { return symbol(sym.OR); }
    "!"                { return symbol(sym.NOT); }
    "+"                { return symbol(sym.PLUS); }
    "-"                { return symbol(sym.MINUS); }
    "*"                { return symbol(sym.TIMES); }
    "/"                { return symbol(sym.DIVIDE); }
    "."                { return symbol(sym.DOT); }
    ","                { return symbol(sym.COMMA); }
    ";"                { return symbol(sym.SEMICOLON); }
    "("                { return symbol(sym.LPAREN); }
    ")"                { return symbol(sym.RPAREN); }
    "["                { return symbol(sym.LBRACKET); }
    "]"                { return symbol(sym.RBRACKET); }
    "{"                { return symbol(sym.LBRACE); }
    "}"                { return symbol(sym.RBRACE); }
    
    /* Identificadores e literais */
    {Identifier}       { return symbol(sym.ID, yytext()); }
    {Integer}          { return symbol(sym.INTEGER, 
                             Integer.valueOf(yytext())); }
    
    /* Comentários e espaços */
    {Comment}          { /* ignore */ }
    {WhiteSpace}       { /* ignore */ }
}

[^]                    { throw new Error("Caractere ilegal: '" + 
                             yytext() + "' na linha " + 
                             yyline + ", coluna " + yycolumn); }