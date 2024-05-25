import 'package:get_pet/features/login/data/datasource/login_datasource.dart';
import 'package:get_pet/features/login/data/datasource/user_datasource.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class LoginRepository {
  Future<UserApiModel?> loginByGoogle();

  Future<UserApiModel?> loginByPhone(String phone);
}

class LoginRepositoryImpl implements LoginRepository {
  final UserDatasource _userDatasource;
  final LoginDatasource _loginDatasource;

  const LoginRepositoryImpl(
    this._userDatasource,
    this._loginDatasource,
  );

  @override
  Future<UserApiModel?> loginByGoogle() async {
    final googleUser = await _loginDatasource.loginByGoogle();

    var user = await _userDatasource.getUserByEmail(googleUser.email);
    user ??= await _userDatasource.addUser(
      UserApiModel(
        name: googleUser.displayName ?? '',
        surname: '',
        email: googleUser.email ?? '',
        telephone: googleUser.phoneNumber ?? '',
        photo: googleUser.photoURL ?? '',
      ),
    );

    return user;
  }

  @override
  Future<UserApiModel?> loginByPhone(String phone) async {
    // await _firebaseDatasource.verifyPhoneNumber(phone);

    var user = await _userDatasource.getUserByPhone(phone);
    user ??= await _userDatasource.addUser(
      UserApiModel(
        name: '',
        surname: '',
        email: '',
        telephone: phone,
        photo: '',
      ),
    );

    return user;
  }
}
