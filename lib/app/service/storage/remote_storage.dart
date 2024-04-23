import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/config.dart';
import 'package:mysql_utils/mysql_utils.dart';

abstract interface class RemoteStorage {
  Future<List<dynamic>> getAllRows(String table);
}

class RemoteStorageImpl implements RemoteStorage {
  @override
  Future<List<dynamic>> getAllRows(String table) async {
    final db = MysqlUtils(
      settings: {
        'host': Config.dbHost,
        'port': Config.dbHostPort,
        'user': Config.dbUser,
        'password': Config.dbUserPass,
        'db': Config.dbName,
        'maxConnections': 10,
        'secure': true,
        'prefix': '',
        'pool': false,
        'collation': 'utf8mb4_general_ci',
        'sqlEscape': true,
      },
      errorLog: (error) {
        LoggerService().e('RemoteStorageImpl.getAllRows()',
            error: error, stackTrace: StackTrace.current);
      },
      sqlLog: (sql) {
        LoggerService().d('RemoteStorageImpl.getAllRows(): $sql');
      },
      connectInit: (db1) {
        LoggerService()
            .d('RemoteStorageImpl.getAllRows(): connectInit complete');
      },
    );

    final result = await db.getAll(table: table, fields: '*');
    await db.close();

    return result;
  }
}
