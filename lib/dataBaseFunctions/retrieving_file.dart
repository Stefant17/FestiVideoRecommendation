import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('Testing/$fileName').putFile(file);
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<ListResult> listFiles() async {
    ListResult results = await storage.ref('Testing').listAll();
    return results; 
  }

}



/*
from video link: https://www.youtube.com/watch?v=sM-WMcX66FI
 */