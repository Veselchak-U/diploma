import 'package:get_pet/features/login/data/datasource/firebase_datasource.dart';
import 'package:get_pet/features/login/data/datasource/user_datasource.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class LoginRepository {
  Future<UserApiModel?> loginByGoogle();

  Future<UserApiModel?> loginByPhone(String phone);
}

class LoginRepositoryImpl implements LoginRepository {
  final UserDatasource _userDatasource;
  final FirebaseDatasource _firebaseDatasource;

  const LoginRepositoryImpl(
    this._userDatasource,
    this._firebaseDatasource,
  );

  @override
  Future<UserApiModel?> loginByGoogle() async {
    final googleUser = await _firebaseDatasource.loginByGoogle();

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
