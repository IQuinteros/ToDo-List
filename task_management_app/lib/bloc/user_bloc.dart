import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
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

  // 1. Iniciar Sesión
  Future<FirebaseUser> _signIn() async => _firebaseRepository.signIn();

  // 1.1. Registrar usuario en base de datos
  void _updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  // Iniciar Sesión Completo
  Future<void> signInAndUpdate() async {
    await _signIn().then((FirebaseUser user) =>
        _updateUserData(
          User(
            id: user.uid,
            displayName: user.displayName,
            email: user.email,
            photoUrl: user.photoUrl
          )
        )
    );
    return;
  }

  // 2. Cerrar Sesión
  void signOut() async => _firebaseRepository.signOut();

  // 3. Flujo de datos de estado
  Stream<FirebaseUser> get authStatus => _firebaseRepository.authStatus;
  Future<FirebaseUser> get currentUser => _firebaseRepository.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}