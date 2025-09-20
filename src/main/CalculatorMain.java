import java.io.FileReader;
import java.io.IOException;
import java_cup.symbol;

public class CalculatorMain {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: java CalculatorMain <input-file>");
            return;
        }
        
        try {
            FileReader reader = new FileReader(args[0]);
            CalculatorLexer lexer = new CalculatorLexer(reader);
            
            System.out.println("Análise léxica da calculadora:");
            System.out.println("===============================");
            
            Symbol token;
            do {
                token = lexer.next_token();
                if (token.sym != sym.EOF) {
                    System.out.println("Token: " + token.sym + 
                                     ", Valor: " + token.value + 
                                     ", Linha: " + token.left + 
                                     ", Coluna: " + token.right);
                }
            } while (token.sym != sym.EOF);
            
        } catch (IOException e) {
            System.err.println("Erro ao ler arquivo: " + e.getMessage());
        }
    }
}