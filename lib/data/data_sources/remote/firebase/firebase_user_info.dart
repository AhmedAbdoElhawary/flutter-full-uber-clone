import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/data/models/personal_info.dart';

class FireStoreUser {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> createNewUser(PersonalInfo userInfo) async {
    await _fireStoreUserCollection
        .doc(userInfo.userId)
        .set(userInfo.toMap());

  }

  static Future<PersonalInfo?> getUserInfo(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snap =
        await _fireStoreUserCollection.doc(userId).get();
    if (snap.exists) {
      return PersonalInfo.fromDocSnap(snap.data());
    } else {
      return null;
    }
  }
}
