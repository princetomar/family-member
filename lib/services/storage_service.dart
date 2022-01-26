import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    // Create a file object
    File file = File(filePath);

    try {
      await storage.ref('Users').child(fileName).putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

 
}
