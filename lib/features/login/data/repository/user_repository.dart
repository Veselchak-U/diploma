import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/login/data/datasource/user_datasource.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class UserRepository {
  Future<UserApiModel> getCurrentUser();

  Future<UserApiModel?> getUserById(int? id);

  Future<void> updateUser(UserApiModel user);
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _userDatasource;
  final LocalStorage _localStorage;

  const UserRepositoryImpl(
    this._userDatasource,
    this._localStorage,
  );

  @override
  Future<UserApiModel> getCurrentUser() async {
    final userId = await _localStorage.getUserId();
    if (userId == null) {
      throw const LogicException('id пользователя не найдено на устройстве');
    }

    final user = await _userDatasource.getUserById(userId);
    if (user == null) {
      throw LogicException('Пользователь id: $userId не найден в БД');
    }

    return user;
  }

  @override
  Future<UserApiModel?> getUserById(int? id) {
    return _userDatasource.getUserById(id);
  }

  @override
  Future<void> updateUser(UserApiModel user) {
    return _userDatasource.updateUser(user);
  }
}
