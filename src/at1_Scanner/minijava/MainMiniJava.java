package at1_Scanner.minijava;

import java.io.FileReader;
import java.io.IOException;
import java_cup.runtime.Symbol;

public class MainMiniJava {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java at1_Scanner.minijava.MainMiniJava <caminho_para_arquivo>");
            return;
        }

        String filePath = args[0];
        try (FileReader reader = new FileReader(filePath)) {
            System.out.println("Analisando o arquivo: " + filePath);
            System.out.println("------------------------------------");
            
            MiniJavaScanner scanner = new MiniJavaScanner(reader);
            Symbol token;
            
            do {
                token = scanner.next_token();
                String tokenName = Sym.values()[token.sym].name();
                
                if(token.sym != Sym.EOF.ordinal()) {
                    System.out.println(
                        "Token: " + tokenName + 
                        " (Linha: " + (token.left + 1) + ", Coluna: " + (token.right + 1) + ")" +
                        (token.value != null ? " [Valor: " + token.value + "]" : "")
                    );
                }
            } while (token.sym != Sym.EOF.ordinal());

            System.out.println("------------------------------------");
            System.out.println("Análise concluída.");

        } catch (IOException e) {
            System.err.println("Erro ao ler o arquivo '" + filePath + "': " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Ocorreu um erro inesperado durante a análise.");
            e.printStackTrace();
        }
    }
}