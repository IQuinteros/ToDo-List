import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/repository/cloud_firestore_api.dart';
import 'package:task_management_app/user/model/user.dart';

class UserCloudFirestoreRepository{

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  Future<bool> updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);

  Future<void> updateUserNames(String name, String lastName, String id) async => _cloudFirestoreAPI.updateUserNames(name, lastName, id);

  Future<bool> hasNamesData(User user) async => _cloudFirestoreAPI.hasNamesData(user);

  Future<UserNames> getUserNames(User user) async => _cloudFirestoreAPI.getUserNames(user);

}