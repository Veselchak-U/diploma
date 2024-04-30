import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class LoginDatasource {
  Future<bool?> verifyPhoneNumber(String phone);

  Future<UserApiModel?> getUser(String phone);

  Future<UserApiModel?> addUser(UserApiModel user);
}

class LoginDatasourceImpl implements LoginDatasource {
  final RemoteStorage _remoteStorage;

  const LoginDatasourceImpl(this._remoteStorage);

  @override
  Future<bool?> verifyPhoneNumber(String phone) {
    final completer = Completer<bool?>();

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        completer.complete(true);
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        final phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: '123123',
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          phoneCredential,
        );

        completer.complete(true);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.completeError(TimeoutException(null));
      },
      timeout: const Duration(seconds: 30),
    );

    return completer.future;
  }

  @override
  Future<UserApiModel?> getUser(String phone) async {
    return UserApiModel(
      id: -1,
      name: '',
      surname: '',
      telephone: '+79185104497',
      photo: '',
    );

    final Map result = await _remoteStorage.select(
      from: 'user',
      where: {'telephone': phone},
    );

    return result.isEmpty
        ? null
        : UserApiModel.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<UserApiModel?> addUser(UserApiModel user) async {
    final result = await _remoteStorage.insert(
      to: 'user',
      data: user.toJson(),
    );

    return getUser(user.telephone);
  }

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
