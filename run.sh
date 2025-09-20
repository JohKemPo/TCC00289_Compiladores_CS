#!/bin/bash

# Script de execução para o projeto de compiladores

echo "Executando projeto..."

# Executar calculadora
echo "=== CALCULADORA ==="
java -cp output:lib/java-cup-11b-runtime.jar CalculatorMain test/calculator/test_calculator.txt

echo ""
echo "=== MINIJAVA ==="
# Executar MiniJava
java -cp output:lib/java-cup-11b-runtime.jar MiniJavaMain test/minijava/test_program.java