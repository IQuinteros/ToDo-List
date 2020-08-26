import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/repository/cloud_firestore_api.dart';
import 'package:task_management_app/task/model/task.dart';

class TaskCloudFirestoreRepository{

  final _cloudFirestoreAPI = CloudFirestoreAPI();


  // Mostrar  TODA la lista de tareas
  //Stream<QuerySnapshot> taskListStream = Firestore.instance.collection(CloudFirestoreAPI().TASKS).snapshots();

  //Stream<QuerySnapshot> get tasksStream => taskListStream;

  // Mostrar MIS tareas
  Stream<QuerySnapshot> allMyTasksListStream(String uid) => Firestore.instance.collection(CloudFirestoreAPI().USERS)
      .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/$uid"))
      .snapshots();

  Stream<QuerySnapshot> myToDoTasksListStream(String uid) => Firestore.instance.collection(CloudFirestoreAPI().USERS)
      .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/$uid"))
      .where("status", isEqualTo: "todo")
      .snapshots();

  Stream<QuerySnapshot> myDoingTasksListStream(String uid) => Firestore.instance.collection(CloudFirestoreAPI().USERS)
      .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/$uid"))
      .where("status", isEqualTo: "doing")
      .snapshots();

  Stream<QuerySnapshot> myDoneTasksListStream(String uid) => Firestore.instance.collection(CloudFirestoreAPI().USERS)
      .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/$uid"))
      .where("status", isEqualTo: "done")
      .snapshots();

  Future<void> updateTask(Task task) async => _cloudFirestoreAPI.updateTask(task);

}