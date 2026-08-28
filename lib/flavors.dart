enum Flavor { dev, staging, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static bool get isDev => appFlavor == Flavor.dev;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Dogão - Dev';
      case Flavor.staging:
        return 'Dogão - Homolog';
      case Flavor.prod:
        return 'Dogão';
    }
  }
}
