package at1_Scanner.calculadora;

import java_cup.runtime.*;

%%

%class CalculadoraScanner
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

DIGITO          = [0-9]
NUM_INT         = {DIGITO}+
NUM_FLOAT       = {DIGITO}+ "." {DIGITO}+
WHITESPACE      = [ \t\r\n]+

%%

{NUM_INT}       { return symbol(CalcSym.NUM_INT, Integer.parseInt(yytext())); }
{NUM_FLOAT}     { return symbol(CalcSym.NUM_FLOAT, Double.parseDouble(yytext())); }
"("             { return symbol(CalcSym.PAREN_ESQ); }
")"             { return symbol(CalcSym.PAREN_DIR); }
"+"             { return symbol(CalcSym.MAIS); }
"-"             { return symbol(CalcSym.MENOS); }
"*"             { return symbol(CalcSym.MULT); }
"/"             { return symbol(CalcSym.DIV); }
"//"            { return symbol(CalcSym.INTDIV); }
"**"            { return symbol(CalcSym.POT); }

{WHITESPACE}    

.               { 
                  System.err.println("Erro léxico: '" + yytext() + "' na linha " + (yyline + 1) + ", coluna " + (yycolumn + 1));
                  return symbol(CalcSym.error);
                }