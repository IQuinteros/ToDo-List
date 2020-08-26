
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

  Future<void> updateTask(Task task) async{
    CollectionReference refTask = _db.collection(TASKS);

    await _auth.currentUser().then((FirebaseUser user){
      DocumentReference _userRef = _db.collection(this.USERS).document(user.uid);

      refTask.add({
        'name': task.name,
        'status': Task.stateToString(task.status),
        'detail': task.detail,
        'color': task.color,
        'finishDate': task.finishDate,
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

}