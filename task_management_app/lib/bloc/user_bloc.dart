import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:task_management_app/task/model/task.dart';
import 'package:task_management_app/task/repository/task_cloud_firestore_repository.dart';
import 'package:task_management_app/user/model/user.dart';
import 'package:task_management_app/user/repository/user_cloud_firestore_repository.dart';
import 'package:task_management_app/user/repository/user_firebase_repository.dart';

class UserBloc extends Bloc
{
  /*
    Casos de uso de la aplicación
   */


  final _cloudFirestoreRepository = UserCloudFirestoreRepository();
  final _firebaseRepository = UserFirebaseRepository();
  final _tasksCloudFirestoreRepository = TaskCloudFirestoreRepository();

  // 1. Iniciar Sesión
  Future<FirebaseUser> _signIn() async => _firebaseRepository.signIn();

  // 1.1. Registrar usuario en base de datos
  Future<bool> _updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  // Iniciar Sesión Completo
  Future<bool> signInAndUpdate() async {
    bool isNew = false;

    await _signIn().then((FirebaseUser user) async {

      isNew = await _updateUserData(
          User(
            id: user.uid,
            displayName: user.displayName,
            email: user.email,
            photoUrl: user.photoUrl,
          )
      );
    }
    );
    return isNew;
  }

  // Obtener los nombres registrados del usuario
  Future<bool> hasNamesData(User user) async => _cloudFirestoreRepository.hasNamesData(user);
  Future<UserNames> getUserNames(User user) async => _cloudFirestoreRepository.getUserNames(user);

  // 2. Cerrar Sesión
  void signOut() async => _firebaseRepository.signOut();

  // 3. Flujo de datos de estado
  Stream<FirebaseUser> get authStatus => _firebaseRepository.authStatus;
  Future<FirebaseUser> get currentUser => _firebaseRepository.currentUser;

  // 4. Ver Datos del usuario
  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await currentUser;
    User userRef = User(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoUrl,
    );

    UserNames userNames = await getUserNames(userRef);

    userRef.firstName = userNames.name;
    userRef.lastName = userNames.lastName;

    User.setCurrentUser(userRef, true);

    return userRef;
  }

  // 5. Obtener las tareas del usuario
  Stream<QuerySnapshot> allMyTaskListStream(String uid) => _tasksCloudFirestoreRepository.allMyTasksListStream(uid);

  Stream<QuerySnapshot> myToDoTasksListStream(String uid) => _tasksCloudFirestoreRepository.myToDoTasksListStream(uid);
  Stream<QuerySnapshot> myDoingTasksListStream(String uid) => _tasksCloudFirestoreRepository.myDoingTasksListStream(uid);
  Stream<QuerySnapshot> myDoneTasksListStream(String uid) => _tasksCloudFirestoreRepository.myDoneTasksListStream(uid);

  // 6. Registrar Tarea
  Future<void> updateTask(Task task) async => _tasksCloudFirestoreRepository.updateTask(task);
  // 7. Modificar Tarea
  Future<void> setDataTask(Task newData) async => _tasksCloudFirestoreRepository.setDataTask(newData);

  // 8. Actualizar Nombre y Apellido
  Future<void> updateUserNames(String name, String lastName, String id) async => _cloudFirestoreRepository.updateUserNames(name, lastName, id);

  // 9. Modificar SOLO EL ESTADO de una tarea
  Future<void> updateStateTask(String idTask, TaskState newState) async => _tasksCloudFirestoreRepository.updateStateTask(idTask, newState);

  // 10. Eliminar Tareas
  Future<void> removeTask(Task taskRef) => _tasksCloudFirestoreRepository.removeTask(taskRef);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}