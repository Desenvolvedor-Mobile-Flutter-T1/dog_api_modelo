import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_model.dart';
import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_remote_datasource.dart';
import 'package:gerencia_estado_injecao_dependencia/src/shared/app_exceptions.dart';

abstract class IBreedRepository {
  Future<BreedModel> getBreed();
}

class BreedRepositoryImpl implements IBreedRepository {
  final IBreedRemoteDatasource datasource;

  BreedRepositoryImpl({required this.datasource});

  @override
  Future<BreedModel> getBreed() async {
    try {
      final result = await datasource.getBreed(animal: 'cachorro');

      return BreedModel.fromMap(result);
    } on TypeError {
      throw ConvertDataException();
    } catch (e) {
      rethrow;
    }
  }
}
