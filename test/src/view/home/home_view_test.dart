import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_injection.dart';
import 'package:gerencia_estado_injecao_dependencia/flavors.dart';
import 'package:gerencia_estado_injecao_dependencia/src/blocs/home/home_bloc.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_model.dart';
import 'package:gerencia_estado_injecao_dependencia/src/view/home/home_view.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockHomeBloc;
  BreedModel model = BreedModel(
    name: 'Clayton',
    temperament: 'Cheio de aura',
    origin: 'SC',
  );
  setUpAll(() {
    F.appFlavor = Flavor.dev;
  });

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    whenListen(mockHomeBloc, const Stream<HomeState>.empty());
    if (injection.isRegistered<HomeBloc>()) {
      injection.unregister<HomeBloc>();
    }
    injection.registerFactory<HomeBloc>(() => mockHomeBloc);
  });

  tearDown(() async {
    if (injection.isRegistered<HomeBloc>()) {
      injection.unregister<HomeBloc>();
    }
  });

  Widget createBaseWidget() => MaterialApp(home: HomeView());

  group('testar estados', () {
    testWidgets('Deve mostrar loading sem estado for inicial', (tester) async {
      when(() => mockHomeBloc.state).thenReturn(HomeInitial());

      await tester.pumpWidget(createBaseWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Abrir dialog'), findsNothing);
      expect(find.text('Chamar Snackbar'), findsNothing);

      expect(find.byType(TextFormField), findsNothing);
    });

    testWidgets('Deve mostrar mensagem de erro se for estado de erro', (
      tester,
    ) async {
      when(
        () => mockHomeBloc.state,
      ).thenReturn(HomeError(message: 'Falha na requisição'));
      await tester.pumpWidget(createBaseWidget());
      expect(find.text('Falha na requisição'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Abrir dialog'), findsNothing);
      expect(find.text('Chamar Snackbar'), findsNothing);
      expect(find.byType(TextFormField), findsNothing);
    });
  });

  group('Testando os formfield', () {
    testWidgets('testar formfield close icone', (tester) async {
      when(() => mockHomeBloc.state).thenReturn(HomeSuccess(breed: model));
      await tester.pumpWidget(createBaseWidget());
      //Não tem que ter o botão de cloase
      expect(find.byIcon(Icons.close), findsNothing);

      //setup para mexer
      final primeiroTextFormField = find.byType(TextFormField).at(0);

      await tester.enterText(
        primeiroTextFormField,
        'Flaco é melhor que Neymar',
      );
      await tester.pump();

      //Tem que aparecer o botão de close
      expect(find.byIcon(Icons.close), findsOneWidget);

      //Testar se o botão esconde o icone
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('testar formfield password', (tester) async {
      when(() => mockHomeBloc.state).thenReturn(HomeSuccess(breed: model));
      await tester.pumpWidget(createBaseWidget());
      //Deve aparecer o icone visibility no estado inicial
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });
  });

  group('Testando chamadas que abrem componentes', () {
    testWidgets('testar se abre a dialog', (tester) async {
      when(() => mockHomeBloc.state).thenReturn(HomeSuccess(breed: model));
      await tester.pumpWidget(createBaseWidget());
      //verificar se dialog não esta na tela
      expect(find.byType(AlertDialog), findsNothing);

      await tester.tap(find.text('Abrir dialog'));
      // pumpAndSettle espera, pump não
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Minha Dialog'), findsOneWidget);
    });

    testWidgets('testar se abre a snackbar', (tester) async {
      when(() => mockHomeBloc.state).thenReturn(HomeSuccess(breed: model));
      await tester.pumpWidget(createBaseWidget());
      //verificar se dialog não esta na tela
      expect(find.byType(SnackBar), findsNothing);
      await tester.tap(find.text('Chamar Snackbar'));
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Aqui snackbar'), findsOneWidget);
    });
  });
}
