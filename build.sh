#!/bin/bash

JAVA_CUP_JAR="lib/java-cup-11b.jar"
JAVA_CUP_RUNTIME_JAR="lib/java-cup-11b-runtime.jar"
JFLEX_JAR="lib/jflex-1.9.1/lib/jflex-full-1.9.1.jar"

echo "=== LIMPANDO BUILD ANTERIOR ==="
rm -f src/at1_Scanner/calculadora/*.java~
rm -f src/at1_Scanner/minijava/*.java~
rm -f src/at1_Scanner/calculadora/CalculadoraParser.java
rm -f src/at1_Scanner/calculadora/CalcSym.java
rm -f src/at1_Scanner/minijava/MiniJavaParser.java
rm -f src/at1_Scanner/minijava/MiniJavaSym.java
rm -f src/at1_Scanner/minijava/MiniJavaScanner.java~
rm -rf build/

echo "=== CONSTRUINDO CALCULADORA ==="

# 1. Gerar parser da Calculadora
java -cp $JAVA_CUP_JAR java_cup.Main -parser CalculadoraParser -symbols CalcSym src/at1_Scanner/calculadora/Calculadora.cup
mv CalculadoraParser.java src/at1_Scanner/calculadora/
mv CalcSym.java src/at1_Scanner/calculadora/

# 2. Gerar scanner da Calculadora
java -jar $JFLEX_JAR src/at1_Scanner/calculadora/Calculadora.flex

# 3. Corrigir EOF no scanner da Calculadora
echo "Corrigindo EOF no CalculadoraScanner..."
sed -i 's/sym\.EOF/CalcSym.EOF/g' src/at1_Scanner/calculadora/CalculadoraScanner.java 2>/dev/null || true

echo "=== CONSTRUINDO MINIJAVA ==="

# 1. Gerar parser do MiniJava
java -cp $JAVA_CUP_JAR java_cup.Main -parser MiniJavaParser -symbols MiniJavaSym src/at1_Scanner/minijava/MiniJava.cup

if [ -f "MiniJavaParser.java" ]; then
    mv MiniJavaParser.java src/at1_Scanner/minijava/
    mv MiniJavaSym.java src/at1_Scanner/minijava/
    
    # 2. Gerar scanner do MiniJava
    java -jar $JFLEX_JAR src/at1_Scanner/minijava/MiniJava.flex
    
    # 3. Corrig EOF no scanner do MiniJava
    echo "Corrigindo EOF no MiniJavaScanner..."
    if [ -f "src/at1_Scanner/minijava/MiniJavaScanner.java" ]; then
        sed -i 's/sym\.EOF/MiniJavaSym.EOF/g' src/at1_Scanner/minijava/MiniJavaScanner.java

        sed -i 's/new java_cup.runtime.Symbol(sym.EOF/new java_cup.runtime.Symbol(MiniJavaSym.EOF/g' src/at1_Scanner/minijava/MiniJavaScanner.java 2>/dev/null || true
        sed -i 's/return symbol(Sym\./return symbol(MiniJavaSym\./g' src/at1_Scanner/minijava/MiniJavaScanner.java 2>/dev/null || true
        sed -i 's/MiniJavaSym\.ordinal()//g' src/at1_Scanner/minijava/MiniJavaScanner.java 2>/dev/null || true
    else
        echo "AVISO: MiniJavaScanner.java não foi gerado"
    fi
else
    echo "ERRO: Parser MiniJava não foi gerado. Verifique MiniJava.cup"
    exit 1
fi

echo "=== COMPILANDO TUDO ==="

# Criar diretório build 
mkdir -p build

# Compila Calculadora
echo "Compilando Calculadora..."
javac -cp ".:$JAVA_CUP_RUNTIME_JAR" -d build src/at1_Scanner/calculadora/*.java 2>&1 | grep -v "deprecated" || true

# Compila MiniJava
echo "Compilando MiniJava..."
javac -cp ".:$JAVA_CUP_RUNTIME_JAR:build" -d build src/at1_Scanner/minijava/*.java 2>&1 | grep -v "deprecated" || true

# Verifica se as classes principais foram compiladas
echo ""
echo "=== VERIFICAÇÃO DO BUILD ==="
if [ -f "build/at1_Scanner/calculadora/CalculadoraParser.class" ]; then
    echo "CalculadoraParser.class - OK"
else
    echo "CalculadoraParser.class - FALTA"
fi

if [ -f "build/at1_Scanner/calculadora/MainCalculadoraComParser.class" ]; then
    echo "MainCalculadoraComParser.class - OK"
else
    echo "MainCalculadoraComParser.class - FALTA"
fi

if [ -f "build/at1_Scanner/minijava/MiniJavaParser.class" ]; then
    echo "MiniJavaParser.class - OK"
else
    echo "MiniJavaParser.class - FALTA"
fi

if [ -f "build/at1_Scanner/minijava/MainMiniJavaComParser.class" ]; then
    echo "MainMiniJavaComParser.class - OK"
else
    echo "MainMiniJavaComParser.class - FALTA"
fi

echo ""
echo "=== BUILD CONCLUÍDO ==="
echo "Para testar:"
echo "  Calculadora: java -cp \"build:lib/java-cup-11b-runtime.jar\" at1_Scanner.calculadora.MainCalculadoraComParser src/at1_Scanner/tests/calculadora/teste1.txt"
echo "  MiniJava:    java -cp \"build:lib/java-cup-11b-runtime.jar\" at1_Scanner.minijava.MainMiniJavaComParser teste.java"