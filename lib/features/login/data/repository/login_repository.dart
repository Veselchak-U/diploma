import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/home/data/datasource/pet_datasource.dart';
import 'package:get_pet/features/home/data/datasource/questions_datasource.dart';
import 'package:get_pet/features/login/data/datasource/login_datasource.dart';
import 'package:get_pet/features/login/data/datasource/user_datasource.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class LoginRepository {
  Future<UserApiModel> loginByGoogle();

  Future<UserApiModel?> loginByPhone(String phone);

  Future<void> logout();

  Future<void> deleteCurrentUser();
}

class LoginRepositoryImpl implements LoginRepository {
  final UserDatasource _userDatasource;
  final LoginDatasource _loginDatasource;
  final LocalStorage _localStorage;
  final PetDatasource _petDatasource;
  final QuestionDatasource _questionDatasource;

  const LoginRepositoryImpl(
    this._userDatasource,
    this._loginDatasource,
    this._localStorage,
    this._petDatasource,
    this._questionDatasource,
  );

  @override
  Future<UserApiModel> loginByGoogle() async {
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
    if (user == null) {
      throw const LogicException('Пользователь не найден в БД');
    }

    final userId = user.id;
    if (userId == null) {
      throw const LogicException('У пользователя не задан id');
    }
    await _localStorage.setUserId(userId);

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

  @override
  Future<void> logout() async {
    await _loginDatasource.logout();
    await _localStorage.setUserId(null);
  }

  @override
  Future<void> deleteCurrentUser() async {
    final userId = await _localStorage.getUserId();
    if (userId == null) {
      throw const LogicException('У пользователя не задан id');
    }

    await _petDatasource.deleteAllByUser(userId);
    await _questionDatasource.deleteAllByUser(userId);
    await _userDatasource.deleteUser(userId);

    await logout();
  }
}
