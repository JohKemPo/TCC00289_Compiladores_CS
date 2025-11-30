package at1_Scanner.minijava;

import java_cup.runtime.*;
import java.io.*;

public class MainMiniJavaComParser {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java MainMiniJavaComParser <arquivo>");
            return;
        }
        
        try (FileReader reader = new FileReader(args[0])) {
            MiniJavaScanner scanner = new MiniJavaScanner(reader);
            MiniJavaParser parser = new MiniJavaParser(scanner);
            
            System.out.println("=== Analisando MiniJava ===");
            Symbol result = parser.parse();
            
            if (result != null) {
                System.out.println("Análise sintática concluída com sucesso!");
            } else {
                System.out.println("Programa inválido");
            }
            
        } catch (Exception e) {
            System.err.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}