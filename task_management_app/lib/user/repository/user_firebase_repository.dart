
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/repository/firebase_api.dart';

class UserFirebaseRepository{

  final _firebaseAuthAPI = FirebaseAPI();

  // Iniciar Sesión
  Future<User> signIn() async => _firebaseAuthAPI.signIn();

  // Cerrar Sesión
  void signOut() async => _firebaseAuthAPI.signOut();

  // Estado de la Sesión
  Stream<User> get authStatus => _firebaseAuthAPI.authStatus;
  User get currentUser => _firebaseAuthAPI.currentUser;

}