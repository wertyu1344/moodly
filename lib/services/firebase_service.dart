import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Create a new user account with an email and password
  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      print("email şu $email");
      print("şifre şu $password");
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      print("User created: ${user?.uid}");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

// Sign in an existing user with an email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    print("email şu $email");
    print("şifre şu $password");
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      print("User signed in: ${user?.uid}");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

// Sign in a user using their Google account
  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
          scopes: ['email', 'profile'], signInOption: SignInOption.standard);
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        UserCredential result = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: (await account.authentication).idToken,
                accessToken: (await account.authentication).accessToken));
        User? user = result.user;
        print("User signed in with Google: ${user?.uid}");
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

// Sign out the current user
  Future<bool> signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'], signInOption: SignInOption.standard);
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      return true;
    } catch (v) {
      print(v);
      return false;
    }
  }
}
