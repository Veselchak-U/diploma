import 'dart:async';

import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class UserDatasource {
  Future<UserApiModel?> getUserById(int? id);

  Future<UserApiModel?> getUserByEmail(String? email);

  Future<UserApiModel?> getUserByPhone(String? phone);

  Future<UserApiModel?> addUser(UserApiModel user);

  Future<int> updateUser(UserApiModel user);
}

class UserDatasourceImpl implements UserDatasource {
  final RemoteStorage _remoteStorage;

  const UserDatasourceImpl(this._remoteStorage);

  @override
  Future<UserApiModel?> getUserById(int? id) async {
    if (id == null) {
      throw const LogicException('Cannot find user with null id');
    }

    final Map result = await _remoteStorage.select(
      from: 'user',
      where: {'iduser': id},
    );

    return result.isEmpty
        ? null
        : UserApiModel.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<UserApiModel?> getUserByEmail(String? email) async {
    if (email == null || email.trim().isEmpty) {
      throw const LogicException('Cannot find user with empty email');
    }

    final Map result = await _remoteStorage.select(
      from: 'user',
      where: {'email': email},
    );

    return result.isEmpty
        ? null
        : UserApiModel.fromJson(result as Map<String, dynamic>);

    // return null;

    // return UserApiModel(
    //   id: -1,
    //   name: '',
    //   surname: '',
    //   email: '',
    //   telephone: '+79185104497',
    //   photo: '',
    // );
  }

  @override
  Future<UserApiModel?> getUserByPhone(String? phone) async {
    if (phone == null || phone.trim().isEmpty) {
      throw const LogicException('Cannot find user with empty phone');
    }

    final Map result = await _remoteStorage.select(
      from: 'user',
      where: {'telephone': phone},
    );

    return result.isEmpty
        ? null
        : UserApiModel.fromJson(result as Map<String, dynamic>);

    // return UserApiModel(
    //   id: -1,
    //   name: '',
    //   surname: '',
    //   telephone: '+79185104497',
    //   photo: '',
    // );
  }

  @override
  Future<UserApiModel?> addUser(UserApiModel user) async {
    await _remoteStorage.insert(
      to: 'user',
      data: user.toJson(),
    );

    return getUserByEmail(user.email);

    // return user.copyWith(
    //   id: -1,
    // );
  }

  @override
  Future<int> updateUser(UserApiModel user) async {
    final userId = user.id;
    if (userId == null) {
      throw const LogicException('Cannot update user with null id');
    }

    return _remoteStorage.update(
      to: 'user',
      data: user.toJson(),
      where: {'iduser': userId},
    );

    // return 0;
  }
}
