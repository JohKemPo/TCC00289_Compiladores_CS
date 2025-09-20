import java_cup.runtime.*;

%%
%class CalculatorLexer
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

Digit          = [0-9]
Integer        = {Digit}+
Float          = {Digit}+\.{Digit}+

%%

<YYINITIAL> {
    "("                { return symbol(sym.LPAREN); }
    ")"                { return symbol(sym.RPAREN); }
    "+"                { return symbol(sym.PLUS); }
    "-"                { return symbol(sym.MINUS); }
    "*"                { return symbol(sym.TIMES); }
    "/"                { return symbol(sym.DIVIDE); }
    "//"               { return symbol(sym.INT_DIV); }
    "**"               { return symbol(sym.POWER); }
    
    {Integer}          { return symbol(sym.INTEGER, 
                             Integer.valueOf(yytext())); }
    {Float}            { return symbol(sym.FLOAT, 
                             Float.valueOf(yytext())); }
    
    {WhiteSpace}       { /* ignore */ }
}

[^]                    { throw new Error("Caractere ilegal: '" + 
                             yytext() + "' na linha " + 
                             yyline + ", coluna " + yycolumn); }