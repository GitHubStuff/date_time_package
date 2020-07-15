import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../modular/app_module.dart';
import '../flavor_config.dart';

const _databaseName = 'test.db';
const _exposeSql = true;
void main() {
  final values = FlavorValues(
    sqliteDatabaseName: _databaseName,
    sqliteDevelopment: _exposeSql,
  );
  FlavorConfig(flavor: Flavor.TEST, values: values);
  runApp(
    ModularApp(module: AppModule()),
  );
}
