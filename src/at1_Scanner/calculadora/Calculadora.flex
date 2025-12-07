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

    private void printToken(String tokenName, Object value, int line, int column) {
        if (value != null) {
            System.out.printf("%-12s: '%s' (valor: %s) [linha %d, coluna %d]%n",
                tokenName, yytext(), value, line + 1, column + 1);
        } else {
            System.out.printf("%-12s: '%s' [linha %d, coluna %d]%n",
                tokenName, yytext(), line + 1, column + 1);
        }
    }
%}

DIGITO          = [0-9]
NUM_INT         = {DIGITO}+
NUM_FLOAT       = {DIGITO}+ "." {DIGITO}+
WHITESPACE      = [ \t\r\n]+

%%

{NUM_INT}       { 
                  int value = Integer.parseInt(yytext());
                  printToken("NUM_INT", value, yyline, yycolumn);
                  return symbol(CalcSym.NUM_INT, value); 
                }
{NUM_FLOAT}     { 
                  double value = Double.parseDouble(yytext());
                  printToken("NUM_FLOAT", value, yyline, yycolumn);
                  return symbol(CalcSym.NUM_FLOAT, value); 
                }
"("             { 
                  printToken("PAREN_ESQ", null, yyline, yycolumn);
                  return symbol(CalcSym.PAREN_ESQ); 
                }
")"             { 
                  printToken("PAREN_DIR", null, yyline, yycolumn);
                  return symbol(CalcSym.PAREN_DIR); 
                }
"+"             { 
                  printToken("MAIS", null, yyline, yycolumn);
                  return symbol(CalcSym.MAIS); 
                }
"-"             { 
                  printToken("MENOS", null, yyline, yycolumn);
                  return symbol(CalcSym.MENOS); 
                }
"*"             { 
                  printToken("MULT", null, yyline, yycolumn);
                  return symbol(CalcSym.MULT); 
                }
"/"             { 
                  printToken("DIV", null, yyline, yycolumn);
                  return symbol(CalcSym.DIV); 
                }
"//"            { 
                  printToken("INTDIV", null, yyline, yycolumn);
                  return symbol(CalcSym.INTDIV); 
                }
"**"            { 
                  printToken("POT", null, yyline, yycolumn);
                  return symbol(CalcSym.POT); 
                }

{WHITESPACE}    

.               { 
                  System.err.println("Erro léxico: '" + yytext() + "' na linha " + (yyline + 1) + ", coluna " + (yycolumn + 1));
                  return symbol(CalcSym.error);
                }