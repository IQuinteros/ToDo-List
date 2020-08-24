
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/user/model/user.dart';

class CloudFirestoreAPI{

  // PATHS
  final String USERS = "users";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add or Update Data
  void updateUserData(User user) async {
    DocumentReference ref =_db.collection(USERS).document(user.id);

    return await ref.setData({
      'id': user.id,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'myTasks': user.myTasks,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }
}