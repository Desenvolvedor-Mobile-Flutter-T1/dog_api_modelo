import 'package:flutter_test/flutter_test.dart';
import 'package:gerencia_estado_injecao_dependencia/src/calculadora.dart';

void main() {
  late final Calculadora calculadora;

  setUpAll(() {
    calculadora = Calculadora();
  });

  group('teste de soma', () {
    test('Calculadora - Deve somar as entradas e retornar um valor válido', () {
      final result = calculadora.somar(4, 6);
      expect(result, 11);
      expect(result, isA<int>());
    });

    test(
      'Calculadora 2- Deve somar as entradas e retornar um valor válido',
      () {
        final result = calculadora.somar(4, 4);
        expect(result, 8);
        expect(result, isA<int>());
      },
    );
  });

  group('teste de subtração', () {
    test(
      'Calculadora - Deve subtrair as entradas e retornar um valor válido',
      () {
        final result = calculadora.subtracao(4, 6);
        expect(result, -2);
        expect(result, isA<int>());
      },
    );

    test(
      'Calculadora 2- Deve subtrair as entradas e retornar um valor válido',
      () {
        final result = calculadora.subtracao(4, 4);
        expect(result, 0);
        expect(result, isA<int>());
      },
    );
  });
}
