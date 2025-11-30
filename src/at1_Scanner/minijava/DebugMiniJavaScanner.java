package at1_Scanner.minijava;

import java_cup.runtime.*;
import java.io.*;

public class DebugMiniJavaScanner {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java DebugMiniJavaScanner <arquivo>");
            return;
        }
        
        try (FileReader reader = new FileReader(args[0])) {
            MiniJavaScanner scanner = new MiniJavaScanner(reader);
            Symbol token;
            
            System.out.println("=== DEBUG SCANNER MINIJAVA ===");
            System.out.println("Arquivo: " + args[0]);
            System.out.println("------------------------------------");
            
            int tokenCount = 0;
            do {
                token = scanner.next_token();
                if (token.sym != MiniJavaSym.EOF) {
                    tokenCount++;
                    String tokenName = "UNKNOWN";
                    Object tokenValue = token.value;
                    
                    try {
                        tokenName = MiniJavaSym.terminalNames[token.sym];
                    } catch (Exception e) {
                        tokenName = "Token#" + token.sym;
                    }
                    
                    System.out.printf("%3d. %-20s [%s] (Linha: %2d, Coluna: %2d)\n",
                        tokenCount, tokenName, tokenValue, 
                        token.left + 1, token.right + 1);
                }
            } while (token.sym != MiniJavaSym.EOF && tokenCount < 50);
            
            System.out.println("------------------------------------");
            System.out.println("Total de tokens: " + tokenCount);
            System.out.println("=== FIM DEBUG ===");
            
        } catch (Exception e) {
            System.err.println("Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
