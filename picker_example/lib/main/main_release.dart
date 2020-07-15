import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../modular/app_module.dart';
import '../flavor_config.dart';

const _databaseName = 'fhcp.db';

void main() {
  final values = FlavorValues(
    sqliteDatabaseName: _databaseName,
    sqliteDevelopment: false,
  );
  FlavorConfig(flavor: Flavor.RELEASE, values: values);
  runApp(
    ModularApp(module: AppModule()),
  );
}
