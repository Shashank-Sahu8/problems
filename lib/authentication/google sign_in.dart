import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  signInWithGoogle() async {
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth = await guser!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
