import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAPI{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Iniciar sesión con Google
  Future<FirebaseUser> signIn() async{

    // Iniciar con Google
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    // Iniciar en Firebase con Google
    FirebaseUser user = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken)
    );

    return user;
  }

  // Cerrar Sesión
  void signOut() async {
    await _auth.signOut().then((onValue){});
    googleSignIn.signOut();

    print("Firebase y Google: Sesiones cerradas");
  }

  // Estado de la Sesión
  Stream<FirebaseUser> _streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => _streamFirebase;

  // Obtener usuario actual
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

}
