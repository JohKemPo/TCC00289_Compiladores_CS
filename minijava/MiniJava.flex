// OPCOES JFL
%%

%class MinijavaScanner
%unicode
%line
%column
%integer
%standalone

// EXPRESSÕES REGULARES
DIGITO          = [0-9]
ID              = [a-zA-Z_][a-zA-Z0-9_]*

%%

// Simbolos e operadores
"{"             { System.out.println("LBRACE: {"); return 20; }
"}"             { System.out.println("RBRACE: }"); return 21; }
"("             { System.out.println("LPAREN: ("); return 22; }
")"             { System.out.println("RPAREN: )"); return 23; }
"["             { System.out.println("LBRACKET: ["); return 24; }
"]"             { System.out.println("RBRACKET: ]"); return 25; }
";"             { System.out.println("SEMICOLON: ;"); return 26; }
","             { System.out.println("COMMA: ,"); return 27; }
"."             { System.out.println("DOT: ."); return 28; }
"="             { System.out.println("EQ: ="); return 29; }
"&&"            { System.out.println("AND: &&"); return 30; }
"<"             { System.out.println("LT: <"); return 31; }
"+"             { System.out.println("PLUS: +"); return 32; }
"-"             { System.out.println("MINUS: -"); return 33; }
"*"             { System.out.println("TIMES: *"); return 34; }
"!"             { System.out.println("NOT: !"); return 35; }

// Palavras reservadas 
"public"        { System.out.println("PUBLIC: " + yytext()); return 3; }
"static"        { System.out.println("STATIC: " + yytext()); return 4; }
"void"          { System.out.println("VOID: " + yytext()); return 5; }
"class"         { System.out.println("CLASS: " + yytext()); return 6; }
"extends"       { System.out.println("EXTENDS: " + yytext()); return 7; }
"return"        { System.out.println("RETURN: " + yytext()); return 8; }
"if"            { System.out.println("IF: " + yytext()); return 9; }
"else"          { System.out.println("ELSE: " + yytext()); return 10; }
"while"         { System.out.println("WHILE: " + yytext()); return 11; }
"System.out.println" { System.out.println("PRINTLN: " + yytext()); return 12; }
"true"          { System.out.println("TRUE: " + yytext()); return 13; }
"false"         { System.out.println("FALSE: " + yytext()); return 14; }
"this"          { System.out.println("THIS: " + yytext()); return 15; }
"new"           { System.out.println("NEW: " + yytext()); return 16; }
"int"           { System.out.println("INT: " + yytext()); return 17; }
"boolean"       { System.out.println("BOOLEAN: " + yytext()); return 18; }
"String"        { System.out.println("STRING: " + yytext()); return 19; }

// Identificadores
"length"        { System.out.println("LENGTH: length"); return 36; }
"main"          { System.out.println("MAIN: main"); return 37; }
{ID}            { System.out.println("IDENTIFIER: " + yytext()); return 1; }

// Números inteiros
{DIGITO}+       { System.out.println("INTEGER_LITERAL: " + yytext()); return 2; }

// Ignorar espaços, tabs, quebras de linha e comentarios
[\r\n\t ]+                       { /* nao faz nada */; }
"//".*                          { /* nao faz nada */; }
"/*"([^*]|\*+[^*/])*\*+"/"      { /* nao faz nada */; }

// Qualquer outro símbolo, erro léxico
.               { System.err.println("Erro: simbolo invalido '" + yytext() +
                                     "' na linha " + yyline + ", coluna " + yycolumn);
                  return -1;
                }