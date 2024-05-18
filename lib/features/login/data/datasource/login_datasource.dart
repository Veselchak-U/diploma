import 'dart:async';

import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class LoginDatasource {
  Future<UserApiModel?> getUserByEmail(String? email);

  Future<UserApiModel?> getUserByPhone(String? phone);

  Future<UserApiModel?> addUser(UserApiModel user);
}

class LoginDatasourceImpl implements LoginDatasource {
  final RemoteStorage _remoteStorage;

  const LoginDatasourceImpl(this._remoteStorage);

  @override
  Future<UserApiModel?> getUserByEmail(String? email) async {
    // if (email == null || email.trim().isEmpty) {
    //   throw const LogicException('Cannot find user with empty email');
    // }
    //
    // final Map result = await _remoteStorage.select(
    //   from: 'user',
    //   where: {'email': email},
    // );
    //
    // return result.isEmpty
    //     ? null
    //     : UserApiModel.fromJson(result as Map<String, dynamic>);

    return UserApiModel(
      id: -1,
      name: '',
      surname: '',
      email: '',
      telephone: '+79185104497',
      photo: '',
    );
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
  }
}
