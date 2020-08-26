import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/repository/cloud_firestore_api.dart';
import 'package:task_management_app/user/model/user.dart';

class UserCloudFirestoreRepository{

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);

}