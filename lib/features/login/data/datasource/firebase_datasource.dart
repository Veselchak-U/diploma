import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class FirebaseDatasource {
  Future<User> loginByGoogle();

  Future<bool?> verifyPhoneNumber(String phone);
}

class FirebaseDatasourceImpl implements FirebaseDatasource {
  @override
  Future<User> loginByGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredentials =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredentials.user;
    if (user == null) {
      throw const LogicException('Login with Google doesn\'t complete');
    }

    return user;
  }

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
}
