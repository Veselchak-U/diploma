import 'package:get_pet/features/login/data/datasource/login_datasource.dart';
import 'package:get_pet/features/login/data/model/login_api_model.dart';

abstract interface class LoginRepository {
  Future<LoginApiModel?> login();
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _loginDatasource;

  LoginRepositoryImpl(this._loginDatasource);

  @override
  Future<LoginApiModel?> login() async {
    return _loginDatasource.login();
  }
}
