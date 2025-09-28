package at1_Scanner.calculadora;

import java.io.FileReader;
import java.io.IOException;

public class MainCalculadora {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Uso: java at1_Scanner.calculadora.MainCalculadora <caminho_para_arquivo>");
            return;
        }

        String filePath = args[0];
        try (FileReader reader = new FileReader(filePath)) {
            System.out.println("Analisando o arquivo: " + filePath);
            System.out.println("------------------------------------");
            
            CalculadoraScanner scanner = new CalculadoraScanner(reader);
            
            while (!scanner.yyatEOF()) {
                scanner.yylex();
            }
            
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