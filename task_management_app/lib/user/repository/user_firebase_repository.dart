
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/repository/firebase_api.dart';

class UserFirebaseRepository{

  final _firebaseAuthAPI = FirebaseAPI();

  // Iniciar Sesión
  Future<FirebaseUser> signIn() async => _firebaseAuthAPI.signIn();

  // Cerrar Sesión
  void signOut() async => _firebaseAuthAPI.signOut();

  // Estado de la Sesión
  Stream<FirebaseUser> get authStatus => _firebaseAuthAPI.authStatus;
  Future<FirebaseUser> get currentUser => _firebaseAuthAPI.currentUser;

}