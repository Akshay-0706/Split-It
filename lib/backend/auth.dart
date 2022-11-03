import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static Future<User?> googleLogin() async {
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredentials =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredentials.user;
  }

  static Future<void> googleLogout() async {
    await FirebaseAuth.instance.signOut();
  }
}
