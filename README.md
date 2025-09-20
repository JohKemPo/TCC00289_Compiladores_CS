# TCC00289_Compiladores_CS

## Guias de instalacao de dependencias

### Instalação e Configuração do JFlex no Ubuntu

#### 1. Instalar Java JDK
sudo apt update
sudo apt install openjdk-17-jdk

#### 2. Instalar JFlex
sudo apt install jflex

#### 3. Verificar instalação
jflex --version

--- 
## Atividade 1: Implementação do Scanner usando JFlex 

Implementar o código para executar no JFlex para criação do Scanner para:

1. Calculadora








# Compilar o scanner da calculadora
jflex Calculator.jflex
javac -cp .:java-cup-11b-runtime.jar CalculatorLexer.java

# Compilar o scanner do MiniJava
jflex MiniJava.jflex
javac -cp .:java-cup-11b-runtime.jar MiniJavaLexer.java

https://www.skenz.it/compilers/install_linux_bash