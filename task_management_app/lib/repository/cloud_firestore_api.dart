
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/user/model/user.dart';

class CloudFirestoreAPI{

  // PATHS
  final String USERS = "users";
  final String TASKS = "tasks";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add or Update Data
  Future<bool> updateUserData(ZUser user) async {
    DocumentReference ref =_db.collection(USERS).doc(user.id);

    bool isNew = false;

    try {
      await ref.get().then((document){
        //print(document.data);
      });
    }catch(e){
      isNew = true;
      print('ES NUEVO USUARIO');
    }

    await ref.set({
      'id': user.id,
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'myTasks': user.myTasks,
      'lastSignIn': DateTime.now()
    });

    return isNew;
  }

  Future<bool> hasNamesData(ZUser user) async {
    DocumentReference ref =_db.collection(USERS).doc(user.id);

    bool hasData = false;

    try {
      ref.get().then((value) {
        if(value.data()['firstName'].toString().length > 0 && value.data()['lastName'].toString().length > 0){
          hasData = true;
        }
      });
    }
    catch(e){}

    return hasData;
  }

  Future<UserNames> getUserNames(ZUser user) async{
    DocumentReference ref =_db.collection(USERS).document(user.id);

    String names = "";
    String lastNames = "";

    try {
      await ref.get().then((value) {
        names = value.data()['firstName'];
        lastNames = value.data()['lastName'];
      });
    }
    catch(e){}

    return UserNames(names, lastNames);
  }

  Future<void> updateUserNames(String name, String lastName, String id) async{
    DocumentReference ref = _db.collection(USERS).document(id);

    return await ref.set({
      'firstName': name,
      'lastName': lastName
    });
  }

  Future<void> updateStateTask(String idTask, TaskState newState) async{
    DocumentReference ref = _db.collection(TASKS).doc(idTask);

    return await ref.set({
      'status': Task.stateToString(newState)
    });
  }

  Future<void> removeTask(Task taskRef){
    DocumentReference ref = _db.collection(TASKS).doc(taskRef.id);

    return ref.delete();
  }

  Future<void> updateTask(Task task) async{
    CollectionReference refTask = _db.collection(TASKS);

    User user = _auth.currentUser;
    
    DocumentReference _userRef = _db.collection(this.USERS).doc(user.uid);

    refTask.add({
      'name': task.name,
      'status': Task.stateToString(task.status),
      'detail': task.detail,
      'color': task.color,
      'finishDate': task.finishDate.millisecondsSinceEpoch,
      'userOwner': _userRef
    }).then((DocumentReference dr){
      dr.get().then((DocumentSnapshot snapshot){
        _userRef.update({
          'myTasks': FieldValue.arrayUnion([
            _db.doc("$TASKS/${snapshot.id}")
          ])
        });
      });
    });
    
  }

  Future<void> setDataTask(Task newData) async{
    DocumentReference ref = _db.collection(TASKS).document(newData.id);

    return await ref.set({
      'name': newData.name,
      'status': Task.stateToString(newData.status),
      'detail': newData.detail,
      'color': newData.color,
      'finishDate': newData.finishDate.millisecondsSinceEpoch,
    });
  }

}