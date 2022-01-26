import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataConroller extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();

    return snapshot.docs;
  }

  // Method for searching purpose
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('uniqueID', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
