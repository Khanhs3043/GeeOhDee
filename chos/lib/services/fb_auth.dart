import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

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
  Future passwordReset(String email,BuildContext context)async{
    try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: null,
      content: Text('Password reset link sent! Check your Email'),
    ));
    } catch (e){
      print(e);
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: null,
        content: Text(e.toString()),
      ));
    }
  }
  static Stream<User?> get authStateChanges => _auth.authStateChanges();
}
