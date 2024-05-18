import 'package:get_pet/features/login/data/datasource/user_datasource.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class UserRepository {
  Future<UserApiModel?> getUserById(int? id);

  Future<void> updateUser(UserApiModel user);
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _userDatasource;

  const UserRepositoryImpl(
    this._userDatasource,
  );

  @override
  Future<UserApiModel?> getUserById(int? id) {
    return _userDatasource.getUserById(id);
  }

  @override
  Future<void> updateUser(UserApiModel user) {
    return _userDatasource.updateUser(user);
  }
}
