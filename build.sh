#!/bin/bash

# Script de compilação para o projeto de compiladores

echo "Compilando projeto..."

# Criar diretório de output se não existir
mkdir -p output

# Compilar calculadora
echo "Compilando calculadora..."
cd src/calculator
java -jar ../../lib/jflex-full-1.9.1.jar Calculator.jflex
javac -cp ../../lib/java-cup-11b-runtime.jar -d ../../output CalculatorLexer.java
cd ../..

# Compilar MiniJava
echo "Compilando MiniJava..."
cd src/minijava
java -jar ../../lib/jflex-full-1.9.1.jar MiniJava.jflex
javac -cp ../../lib/java-cup-11b-runtime.jar -d ../../output MiniJavaLexer.java
cd ../..

# Compilar programas principais
echo "Compilando programas principais..."
javac -cp output:lib/java-cup-11b-runtime.jar -d output src/main/CalculatorMain.java
javac -cp output:lib/java-cup-11b-runtime.jar -d output src/main/MiniJavaMain.java

echo "Compilação concluída!"