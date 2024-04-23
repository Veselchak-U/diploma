import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Config {
  static const appName = 'Get-pet';

  static const dbHost = String.fromEnvironment('DB_HOST');
  static const dbHostPort = int.fromEnvironment('DB_HOST_PORT');
  static const dbUser = String.fromEnvironment('DB_USER');
  static const dbUserPass = String.fromEnvironment('DB_USER_PASS');
  static const dbName = String.fromEnvironment('DB_NAME');

  static late final String appFolder;

  static Future<void> init() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    appFolder = switch (Platform.operatingSystem) {
      "windows" => p.join(appDirectory.path, appName),
      _ => appDirectory.path,
    };
  }
}
