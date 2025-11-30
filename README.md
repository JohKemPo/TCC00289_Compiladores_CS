# TCC00289_Compiladores_CS



# 1. Scanner ( Primeiro Trabalho )

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


# 2. Parser ( Trabalho Final )

## Permitindo a execução

```
chmod +x build.sh
```

## Compilando os parser usando .cup ( Versao similar do YACC ( CMINUS ) porem para minijava ( JAVACUP ))


```
cd TCC00289_Compiladores_CS/
build.sh
```


## Testar a Calculadora

`EXECUTAR DA RAIZ DO PROJETO`

```
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.calculadora.MainCalculadoraComParser src/at1_Scanner/tests/calculadora/teste_calc.txt
```
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.MainMiniJavaComParser


-------------------------

# TCC00289_Compiladores_CS 

## Sobre o Projeto

Implementação completa de analisadores léxico e sintático para duas linguagens:
- **Calculadora**: Linguagem para expressões aritméticas com precedência
- **MiniJava**: Subconjunto educacional da linguagem Java

**Ferramentas utilizadas:** JFlex (scanner) + Java CUP (parser)

## Objetivos da Atividade

### Requisitos Implementados

1. **Análise da Gramática da Calculadora** - Verificação LL(1), LR(0), SLR(1), LALR(1)
2. **Tabela SLR e Parsing** - Construção de tabela e demonstração com cadeias válidas e com erro  
3. **Parser com Java CUP** - Geração de parsers para Calculadora e MiniJava
4. **Execução Integrada** - Scanner + Parser funcionando
5. **Relatório Completo** - Documentação 

## Guia Rápido para Avaliador

### Pré-requisitos
- Java JDK 8+
- Permissão de execução no sistema

### 1. Compilação Completa do Projeto

```bash
chmod +x build.sh

./build.sh
```

**Saída esperada:**
```
=== Building Calculadora ===
[...]
=== Building MiniJava ===  
[...]
=== Compiling all ===
=== Build complete ===
```

### 2. Testar os Requisitos da Atividade

#### **Item 1 & 2: Análise da Gramática e Tabela SLR**
- **Evidência:** Documentado no relatório PDF
- **Gramática analisada:** `src/at1_Scanner/calculadora/Calculadora.cup`
- **Resultado:** Gramática é SLR(1) e LALR(1), mas não `LL(1)` ou `LR(0)`

#### **Item 3: Parser com Java CUP** 
```bash
# Verificar parsers gerados
ls -la src/at1_Scanner/calculadora/CalculadoraParser.java
ls -la src/at1_Scanner/minijava/MiniJavaParser.java
```

#### **Item 4: Execução Scanner + Parser**

##### Calculadora 

```bash
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.calculadora.MainCalculadoraComParser src/at1_Scanner/tests/calculadora/teste1.txt
```

**Saída esperada:**
```
=== Analisando Calculadora ===
Resultado: -23.990000000000002
```

##### MiniJava - **SCANNER e PARSER**
```bash
# Debug do scanner
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.DebugMiniJavaScanner src/at1_Scanner/tests/minijava/fatorial.txt

# Teste do parser 
java -cp "build:lib/java-cup-11b-runtime.jar" at1_Scanner.minijava.MainMiniJavaComParser src/at1_Scanner/tests/minijava/fatorial.txt
```

### 3.  Estrutura do Projeto

```
TCC00289_Compiladores_CS/
├── build/                          
│   └── at1_Scanner/
│       ├── calculadora/            
│       └── minijava/               
├── src/at1_Scanner/
│   ├── calculadora/
│   │   ├── Calculadora.cup         # Gramática do parser
│   │   ├── Calculadora.flex        # Especificação do scanner
│   │   └── MainCalculadoraComParser.java
│   ├── minijava/
│   │   ├── MiniJava.cup            # Gramática do parser  
│   │   ├── MiniJava.flex           # Especificação do scanner
│   │   └── DebugMiniJavaScanner.java # Ferramenta de debug
│   └── tests/                      # Casos de teste
├── lib/                            # Dependências (JFlex, Java CUP)
├── build.sh                       
└── README.md                       
```

### 4. Testes

```bash
chmod +x teste_final.sh
./teste_final.sh
```

### 5. 📊 Resultados por Item da Atividade [ENTREGAVEIS]

| Item | Status | Evidência |
|------|--------|-----------|
| 1. Análise Gramática Calculadora | OK | Relatório + Código |
| 2. Tabela SLR e Parsing | OK | Relatório + Execução |
| 3. Parser Java CUP | OK | Parsers gerados |
| 4. Execução Scanner+Parser | OK | Calculadora funcional |
| 5. Relatório Completo | OK | Documentação |



## Apêndice

Para qualquer problema na execução:
1. Verificar permissões: `chmod +x build.sh teste_final.sh`
2. Confirmar Java: `java -version`
3. Executar build passo a passo: `./build.sh`

---
