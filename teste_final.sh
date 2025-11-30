#!/bin/bash

echo "=== TESTE FINAL COMPLETO ==="

echo ""
echo "1. CALCULADORA - TESTE COMPLETO:"
echo "Expressão: 2.5 + 3 * (4 // 2) - 5.7 ** 2"
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.calculadora.MainCalculadoraComParser src/at1_Scanner/tests/calculadora/teste1.txt

echo ""
echo "2. MINIJAVA - DEBUG SCANNER:"


javac -cp "lib/java-cup-11b-runtime.jar:build" -d build src/at1_Scanner/minijava/DebugMiniJavaScanner.java 2>/dev/null
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.DebugMiniJavaScanner src/at1_Scanner/tests/minijava/fatorial.txt

echo ""
echo "3. MINIJAVA - TESTE PARSER:"
cat > teste_final.java << 'EOF'
class Teste { public static void main(String[] a) { } }
EOF
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.MainMiniJavaComParser teste_final.java
rm -f teste_final.java

echo ""
echo "=== FIM DOS TESTES ==="