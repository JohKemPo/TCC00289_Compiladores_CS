#!/bin/bash

echo "TESTE FINAL COMPLETO - SCANNER + PARSER"
echo "=========================================="

echo ""
echo "1. CALCULADORA - PARSER"
echo "   Expressão: 2.5 + 3 * (4 // 2) - 5.7 ** 2"
echo "   ----------------------------------------"
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.calculadora.MainCalculadoraComParser src/at1_Scanner/tests/calculadora/teste1.txt

echo ""
echo "2. ☕ MINIJAVA - PARSER"
echo "   Programa: class Teste { public static void main(String[] args) { } }"
echo "   ----------------------------------------------------------------"
cat > teste_minijava_sucesso.java << 'EOF'
class Teste { public static void main(String[] args) { } }
EOF
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.MainMiniJavaComParser teste_minijava_sucesso.java
rm -f teste_minijava_sucesso.java

echo ""
echo "3. MINIJAVA - DEBUG SCANNER (fatorial.txt)"
echo "   Mostrando primeiros 20 tokens do programa completo"
echo "   ------------------------------------------------"
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.DebugMiniJavaScanner src/at1_Scanner/tests/minijava/fatorial.txt 2>&1 | head -25

echo ""
echo "4. MINIJAVA - PARSER COM PROGRAMA COMPLETO"
echo "   Testando com fatorial.txt"
echo "   --------------------------------------------------------------------"
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.MainMiniJavaComParser src/at1_Scanner/tests/minijava/fatorial.txt 2>&1 | head -5


echo ""
echo "=== FIM DOS TESTES ==="