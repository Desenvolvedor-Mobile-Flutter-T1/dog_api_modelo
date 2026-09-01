import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerencia_estado_injecao_dependencia/src/blocs/home/home_bloc.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_model.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/brred_repository.dart';
import 'package:mocktail/mocktail.dart';

class BreedRepositoryMock extends Mock implements IBreedRepository {}

class BreedModelMock extends Mock implements BreedModel {}

void main() {
  late final IBreedRepository repository;
  late final HomeBloc bloc;
  setUpAll(() {
    repository = BreedRepositoryMock();
    bloc = HomeBloc(repository);
  });

  tearDownAll(() {
    bloc.close();
  });

  test('deve emitir os eventos de loading, success', () {
    when(() => repository.getBreed()).thenAnswer((_) async => BreedModelMock());
    expectLater(
      bloc.stream,
      emitsInOrder([isA<HomeLoading>(), isA<HomeSuccess>()]),
    );
    bloc.add(HomeEventGetBreed());
  });

  blocTest(
    'deve retornar os estados de loading e sucesso',
    build: () => bloc,
    act: (bloc) => bloc.add(HomeEventGetBreed()),
    setUp: () => when(
      () => repository.getBreed(),
    ).thenAnswer((_) async => BreedModelMock()),
    expect: () => [isA<HomeLoading>(), isA<HomeSuccess>()],
  );
}
