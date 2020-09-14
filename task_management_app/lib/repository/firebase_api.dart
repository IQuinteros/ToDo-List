import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAPI{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Iniciar sesión con Google
  Future<User> signIn() async{

    print('SignIn');
    // Iniciar con Google
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    print('GoogleSignIn');
    // Iniciar en Firebase con Google
    UserCredential user = await _auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: gSA.idToken, accessToken: gSA.accessToken)
    );
    print(user.user);

    return user.user;
  }

  // Cerrar Sesión
  void signOut() async {
    await _auth.signOut().then((onValue){});
    googleSignIn.signOut();

    print("Firebase y Google: Sesiones cerradas");
  }

  // Estado de la Sesión
  Stream<User> _streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<User> get authStatus => _streamFirebase;

  // Obtener usuario actual
  User get currentUser => FirebaseAuth.instance.currentUser;

}
