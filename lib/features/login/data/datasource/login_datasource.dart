import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/login/data/model/login_api_model.dart';

abstract interface class LoginDatasource {
  Future<LoginApiModel?> login();
}

class LoginDatasourceImpl implements LoginDatasource {
  final RemoteStorage _remoteStorage;

  const LoginDatasourceImpl(this._remoteStorage);

  @override
  Future<LoginApiModel?> login() async {
    await _remoteStorage.getAllRows('category');

    // for (final row in result.rowsAssoc) {
    //   print(row);
    // }
    //
    // print(result);

    return null;

    // return _client.post(
    //   Uri.parse(Config.environment.baseUrl).replace(path: ApiEndpoints.login),
    //   body: {
    //     'name': 'name',
    //     'code': code,
    //   },
    //   parser: (response) {
    //     if (response.body case final Map<String, dynamic> data) {
    //       return LoginApiModel.fromJson(data);
    //     }
    //
    //     throw ApiException(response);
    //   },
    // );
  }
}
