import 'package:flutter/services.dart';
import 'package:gerencia_estado_injecao_dependencia/core/app_bootstrap.dart';

import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  bootstrap();
}
