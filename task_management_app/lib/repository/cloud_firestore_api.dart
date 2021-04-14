
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/user/model/user.dart';

class CloudFirestoreAPI{

  // PATHS
  final String USERS = "users";
  final String TASKS = "tasks";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add or Update Data
  Future<bool> updateUserData(User user) async {
    DocumentReference ref =_db.collection(USERS).document(user.id);

    bool isNew = false;

    try {
      await ref.get().then((document){
        print(document.data.length);
      });
    }catch(e){
      isNew = true;
      print('ES NUEVO USUARIO');
    }

    await ref.setData({
      'id': user.id,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'myTasks': user.myTasks,
      'lastSignIn': DateTime.now()
    }, merge: true);

    return isNew;
  }

  Future<bool> hasNamesData(User user) async {
    DocumentReference ref =_db.collection(USERS).document(user.id);

    bool hasData = false;

    try {
      ref.get().then((value) {
        if(value.data['firstName'].toString().length > 0 && value.data['lastName'].toString().length > 0){
          hasData = true;
        }
      });
    }
    catch(e){}

    return hasData;
  }

  Future<void> updateUserNames(String name, String lastName, String id) async{
    DocumentReference ref = _db.collection(USERS).document(id);

    return await ref.setData({
      'firstName': name,
      'lastName': lastName
    }, merge: true);
  }

  Future<void> updateTask(Task task) async{
    CollectionReference refTask = _db.collection(TASKS);

    await _auth.currentUser().then((FirebaseUser user){
      DocumentReference _userRef = _db.collection(this.USERS).document(user.uid);

      refTask.add({
        'name': task.name,
        'status': Task.stateToString(task.status),
        'detail': task.detail,
        'color': task.color,
        'finishDate': task.finishDate.millisecondsSinceEpoch,
        'userOwner': _userRef
      }).then((DocumentReference dr){
        dr.get().then((DocumentSnapshot snapshot){
          _userRef.updateData({
            'myTasks': FieldValue.arrayUnion([
              _db.document("$TASKS/${snapshot.documentID}")
            ])
          });
        });
      });
    });
  }

  Future<void> setDataTask(Task newData) async{
    DocumentReference ref = _db.collection(TASKS).document(newData.id);

    return await ref.setData({
      'name': newData.name,
      'status': Task.stateToString(newData.status),
      'detail': newData.detail,
      'color': newData.color,
      'finishDate': newData.finishDate.millisecondsSinceEpoch,
    }, merge: true);
  }

}