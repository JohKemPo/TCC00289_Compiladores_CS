#!/bin/bash

JAVA_CUP_JAR="lib/java-cup-11b.jar"
JAVA_CUP_RUNTIME_JAR="lib/java-cup-11b-runtime.jar"
JFLEX_JAR="lib/jflex-1.9.1/lib/jflex-full-1.9.1.jar"

echo "=== Cleaning previous builds ==="
rm -f src/at1_Scanner/calculadora/*.java~
rm -f src/at1_Scanner/minijava/*.java~
rm -f src/at1_Scanner/calculadora/CalculadoraParser.java
rm -f src/at1_Scanner/calculadora/CalcSym.java
rm -f src/at1_Scanner/minijava/MiniJavaParser.java
rm -f src/at1_Scanner/minijava/MiniJavaSym.java

echo "=== Building Calculadora ==="

java -cp $JAVA_CUP_JAR java_cup.Main -parser CalculadoraParser -symbols CalcSym src/at1_Scanner/calculadora/Calculadora.cup
mv CalculadoraParser.java src/at1_Scanner/calculadora/
mv CalcSym.java src/at1_Scanner/calculadora/

java -jar $JFLEX_JAR src/at1_Scanner/calculadora/Calculadora.flex

echo "=== CalculadoraScanner ==="
sed -i 's/sym.EOF/CalcSym.EOF/g' src/at1_Scanner/calculadora/CalculadoraScanner.java

echo "=== Building MiniJava ==="

java -cp $JAVA_CUP_JAR java_cup.Main -parser MiniJavaParser -symbols MiniJavaSym src/at1_Scanner/minijava/MiniJava.cup

if [ -f "MiniJavaParser.java" ]; then
    mv MiniJavaParser.java src/at1_Scanner/minijava/
    mv MiniJavaSym.java src/at1_Scanner/minijava/
    
    java -jar $JFLEX_JAR src/at1_Scanner/minijava/MiniJava.flex
else
    echo "AVISO: Parser MiniJava não foi gerado devido a erros"
fi

echo "=== Compiling all ==="

javac -cp ".:$JAVA_CUP_RUNTIME_JAR" -d build src/at1_Scanner/calculadora/*.java

if [ -f "src/at1_Scanner/minijava/MiniJavaParser.java" ]; then
    javac -cp ".:$JAVA_CUP_RUNTIME_JAR:build" -d build src/at1_Scanner/minijava/*.java
else
    echo "AVISO: Não foi possível compilar MiniJava - parser não gerado"
fi

echo "=== Build complete ==="