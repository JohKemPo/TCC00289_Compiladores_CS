class Main {
    public static void main(String[] a) {
        System.out.println(new Calculator().calculate());
    }
}

class Calculator {
    public int calculate() {
        int x;
        int y;
        x = 10;
        y = 5;
        return x * y;
    }
}