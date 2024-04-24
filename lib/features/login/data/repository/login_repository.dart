import 'package:get_pet/features/login/data/datasource/login_datasource.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class LoginRepository {
  Future<UserApiModel?> login(String phone);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _loginDatasource;

  LoginRepositoryImpl(this._loginDatasource);

  @override
  Future<UserApiModel?> login(String phone) async {
    await _loginDatasource.verifyPhoneNumber(phone);

    var user = await _loginDatasource.getUser(phone);
    user ??= await _loginDatasource.addUser(
      UserApiModel(
        iduser: -1,
        name: '',
        surname: '',
        telephone: phone,
        photo: '',
      ),
    );

    return user;
  }
}
