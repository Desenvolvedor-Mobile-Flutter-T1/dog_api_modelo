import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_injection.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_model.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_remote_datasource.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/brred_repository.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_exceptions.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class DatasourceMock extends Mock implements IBreedRemoteDatasource {}

void main() {
  late IBreedRemoteDatasource datasource;
  late BreedRepositoryImpl repositoryImpl;

  setUp(() {
    GetIt di = GetIt.instance;

    di.registerFactory(() => datasource);
    datasource = DatasourceMock();
    repositoryImpl = BreedRepositoryImpl(datasource: datasource);
  });

  tearDown(() {
    GetIt di = GetIt.instance;
    di.reset();
  });

  test('Deve retornar um BreedModel quando recebe um map válido', () async {
    when(() => datasource.getBreed(animal: any(named: 'animal'))).thenAnswer(
      (_) async => <String, dynamic>{
        'name': '67',
        'temperament': 'Farmador',
        'origin': 'origin',
      },
    );
    final result = await repositoryImpl.getBreed();

    expect(result, isA<BreedModel>());
    expect(result.name, equals('67'));
    verify(() => datasource.getBreed(animal: any(named: 'animal'))).called(1);
  });

  test(
    'Deve retornar um BreedModel quando recebe um map válido com o nome Clayton',
    () async {
      when(() => datasource.getBreed(animal: any())).thenAnswer(
        (_) async => <String, dynamic>{
          'name': 'Clayton',
          'temperament': 'Farmador',
          'origin': 'origin',
        },
      );
      final result = await repositoryImpl.getBreed();

      expect(result, isA<BreedModel>());
      expect(result.name, equals('Clayton'));
      verify(() => datasource.getBreed(animal: any())).called(1);
    },
  );

  test(
    'Deve retornar um ConvertDataException quando o repository recebe do datasource um TypeError',
    () async {
      when(() => datasource.getBreed(animal: any())).thenThrow(TypeError());
      await expectLater(
        repositoryImpl.getBreed(),
        throwsA(isA<ConvertDataException>()),
      );
    },
  );
}
