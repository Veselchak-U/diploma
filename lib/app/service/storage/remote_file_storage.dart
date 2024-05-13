import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:uuid/uuid.dart';

abstract interface class RemoteFileStorage {
  Future<String> uploadUserImage(File file);
}

class RemoteFileStorageImpl implements RemoteFileStorage {
  static const _usersImagesPath = 'images/users';

  final LocalStorage _localStorage;

  const RemoteFileStorageImpl(this._localStorage);

  @override
  Future<String> uploadUserImage(File file) async {
    final fileRef = await _getUserImageFileRef(file);
    await fileRef.putFile(file);
    final fileUrl = await fileRef.getDownloadURL();

    return fileUrl;
  }

  Future<Reference> _getUserImageFileRef(File file) async {
    final userId = await _localStorage.getUserId();
    final fileName = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child('$_usersImagesPath/$userId/$fileName');

    return fileRef;
  }
}
