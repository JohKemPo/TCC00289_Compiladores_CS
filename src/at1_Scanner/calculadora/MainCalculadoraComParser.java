package at1_Scanner.calculadora;

import java_cup.runtime.*;
import java.io.*;

public class MainCalculadoraComParser {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java MainCalculadoraComParser <arquivo>");
            return;
        }
        
        try (FileReader reader = new FileReader(args[0])) {
            CalculadoraScanner scanner = new CalculadoraScanner(reader);
            CalculadoraParser parser = new CalculadoraParser(scanner);
            
            System.out.println("=== Analisando Calculadora ===");
            Symbol result = parser.parse();
            
            if (result != null) {
                System.out.println("Resultado: " + result.value);
            } else {
                System.out.println("Expressão inválida");
            }
            
        } catch (Exception e) {
            System.err.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}