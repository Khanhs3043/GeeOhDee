import "package:firebase_auth/firebase_auth.dart";

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? _currentUser;
  Future<User?> registerUserWithEmailAndPassword(

      String strEmail, String strPassword) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: strEmail, password: strPassword);
      return credential.user;
    } catch (err) {
      print("something wrong: $err");
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      String strEmail, String strPassword) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: strEmail, password: strPassword);
      return credential.user;
    } catch (err) {
      print("Tai khoan hoac mat khau khong dung: $err");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print("something wrong: $err");
    }
  }
  static Stream<User?> get authStateChanges => _auth.authStateChanges();
}
