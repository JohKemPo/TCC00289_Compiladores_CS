package at1_Scanner.calculadora;
import java.io.IOException;

%%

%class CalculadoraScanner
%unicode
%public
%final
%line
%column
%standalone
%integer

DIGITO          = [0-9]
NUM_INT         = {DIGITO}+
NUM_FLOAT       = {DIGITO}+ "." {DIGITO}+

%%

{NUM_INT}       { System.out.println("NUM_INT: " + yytext()); return 1; }

{NUM_FLOAT}     { System.out.println("NUM_FLOAT: " + yytext()); return 2; }

"("             { System.out.println("PAREN_ESQ: ("); return 3; }
")"             { System.out.println("PAREN_DIR: )"); return 4; }
"+"             { System.out.println("MAIS: +"); return 5; }
"-"             { System.out.println("MENOS: -"); return 6; }
"*"             { System.out.println("MULT: *"); return 7; }
"/"             { System.out.println("DIV: /"); return 8; }
"//"            { System.out.println("INTDIV: //"); return 9; }
"**"            { System.out.println("POT: **"); return 10; }

// Ignorar espaços, tabs e quebras de linha
[ \t\r\n]+   { /* nao faz nada */; }

// Qualquer outro símbolo, erro léxico
.               { System.err.println("Erro: simbolo invalido '" + yytext() +
                                     "' na linha " + yyline + ", coluna " + yycolumn);
                  return -1;
                }