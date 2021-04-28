import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class AdditionalServices {
  AdditionalServices._interanal();

  static final AdditionalServices _additionalServices =
      AdditionalServices._interanal();

  FirebaseStorage storage = FirebaseStorage.instance;

  factory AdditionalServices() {
    return _additionalServices;
  }

  Future<bool> uploadImage(File file) async {
    var name = file.path;
    var ref = storage.ref().child("uploads/$name");
    var res = await ref.putFile(file);

    await res.ref
        .getDownloadURL()
        .then((value) => print("uploaded image line:$value"));

    return true;
  }
}
