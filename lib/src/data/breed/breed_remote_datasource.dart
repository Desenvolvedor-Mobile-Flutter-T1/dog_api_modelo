import 'package:gerencia_estado_injecao_dependencia/src/shared/app_client/app_client.dart';

abstract class IBreedRemoteDatasource {
  Future<Map<String, dynamic>> getBreed({required String animal});
}

class BreedRemoteDatasourceImpl implements IBreedRemoteDatasource {
  final AppClient client;

  BreedRemoteDatasourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getBreed({required String animal}) async {
    final result = await client.get(
      url: 'https://api.thedogapi.com/v1/breeds/1',
      header: {
        'x-api-key':
            'live_sAQtB5PmXpBasJuhm9UU27CfHmnGaOLYySV0XWVyhkRaM1485Ljvx5xru4iYaG1w',
      },
    );

    return result;
  }
}
