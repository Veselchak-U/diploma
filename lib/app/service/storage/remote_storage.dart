import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/config.dart';
import 'package:mysql_utils/mysql_utils.dart';

abstract interface class RemoteStorage {
  Future<List<dynamic>> select({
    required String from,
    required Map<String, dynamic> where,
  });

  Future<dynamic> selectOne({
    required String from,
    required Map<String, dynamic> where,
  });

  Future<int> insert({
    required String to,
    required Map<String, dynamic> data,
    bool replace = false,
  });

  Future<int> update({
    required String to,
    required Map<String, dynamic> data,
    required Map<String, dynamic> where,
  });

  Future<int> delete({
    required String from,
    required Map<String, dynamic> where,
  });
}

class RemoteStorageImpl implements RemoteStorage {
  static const _requestTimeOut = Duration(seconds: 30);

  MysqlUtils get _db => MysqlUtils(
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
          LoggerService().e('RemoteStorageImpl.MysqlUtils',
              error: error, stackTrace: StackTrace.current);
          throw error;
        },
        sqlLog: (sql) {
          LoggerService().d('RemoteStorageImpl.MysqlUtils: $sql');
        },
        connectInit: (db1) {
          LoggerService()
              .d('RemoteStorageImpl.MysqlUtils: connectInit complete');
        },
      );

  @override
  Future<List<dynamic>> select({
    required String from,
    required Map<String, dynamic> where,
  }) async {
    final result = await _db
        .getAll(
          table: from,
          fields: '*',
          where: where,
          debug: true,
        )
        .timeout(_requestTimeOut);

    await _db.close();

    return result;
  }

  @override
  Future<dynamic> selectOne({
    required String from,
    required Map<String, dynamic> where,
  }) async {
    final result = await _db
        .getOne(
          table: from,
          fields: '*',
          where: where,
          debug: true,
        )
        .timeout(_requestTimeOut);

    await _db.close();

    return result;
  }

  @override
  Future<int> insert({
    required String to,
    required Map<String, dynamic> data,
    bool replace = false,
  }) async {
    final result = await _db
        .insert(
          table: to,
          insertData: data,
          replace: replace,
          debug: true,
        )
        .timeout(_requestTimeOut);

    await _db.close();

    return result;
  }

  @override
  Future<int> update({
    required String to,
    required Map<String, dynamic> data,
    required Map<String, dynamic> where,
  }) async {
    final result = await _db
        .update(
          table: to,
          updateData: data,
          where: where,
        )
        .timeout(_requestTimeOut);

    await _db.close();

    return result;
  }

  @override
  Future<int> delete({
    required String from,
    required Map<String, dynamic> where,
  }) async {
    final result = await _db
        .delete(
          table: from,
          where: where,
        )
        .timeout(_requestTimeOut);

    await _db.close();

    return result;
  }
}
