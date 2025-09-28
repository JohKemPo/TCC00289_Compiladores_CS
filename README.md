# TCC00289_Compiladores_CS



# Compilando o projeto

Para criar os arquivos arquivos CalculadoraScanner.java e MiniJavaScanner.java, execute os comandos na raiz do projeto:

## Gerar o scanner da Calculadora 

``` 
java -jar lib/jflex-1.9.1/lib/jflex-full-1.9.1.jar src/at1_Scanner/calculadora/Calculadora.flex 

``` 
## Gerar o scanner do MiniJava 

``` 
java -jar lib/jflex-1.9.1/lib/jflex-full-1.9.1.jar src/at1_Scanner/minijava/MiniJava.flex

``` 
## Compilar o projeto, gerar as builds

``` 
javac -d src/at1_Scanner/build src/at1_Scanner/calculadora/*.java

e 

javac -cp "lib/java-cup-11b-runtime.jar:src/at1_Scanner/build" -d src/at1_Scanner/build src/at1_Scanner/minijava/*.java

``` 


# Execução


## Testando o Scanner da Calculadora

```
java -cp src/at1_Scanner/build at1_Scanner.calculadora.CalculadoraScanner src/at1_Scanner/tests/calculadora/teste1.txt
```

- Testando um arquivo com erro

```
java -cp src/at1_Scanner/build at1_Scanner.calculadora.MainCalculadora src/at1_Scanner/tests/calculadora/teste2.txt
```

## Testando o Scanner do MiniJava

```
java -cp "src/at1_Scanner/build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.MainMiniJava src/at1_Scanner/tests/minijava/fatorial.txt
```