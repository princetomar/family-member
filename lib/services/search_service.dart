import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchService {
  searchByID(String searchField) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('uniqueID', isEqualTo: searchField)
        .get();
  }
}
