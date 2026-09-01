import 'package:gerencia_estado_injecao_dependencia/src/data/breed/breed_model.dart';

class BreedModelFixtures {
  static BreedModel breedModelHuskyFixture = BreedModel(
    name: 'Husky',
    temperament: 'Calmo',
    origin: 'Russia',
  );
  static BreedModel breedModelChouchouFixture = BreedModel(
    name: 'Chou Chou',
    temperament: 'Capeta',
    origin: 'China',
  );

  static List listBreedModelFixture = [
    breedModelHuskyFixture,
    breedModelChouchouFixture,
  ];
}
