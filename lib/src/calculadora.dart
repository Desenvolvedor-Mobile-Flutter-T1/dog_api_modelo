class Calculadora {
  int somar(int x, int y) {
    subtracao(x, y);
    subtracao(x, y);
    return x + y + 1;
  }

  int subtracao(int x, int y) => x - y;
}
