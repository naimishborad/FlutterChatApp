
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {

  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static var userId;

  final SharedPreferences prefs;

  Auth(this.prefs);


  Future createUser(String email,String password)async{
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

   Future loginUser(String email,String password)async{
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email)async{
     await auth.sendPasswordResetEmail(email: email);
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential = await auth.signInWithCredential(credential);
      final User? user = UserCredential.user;
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = await auth.currentUser;
      assert(currentUser!.uid == user!.uid);
      print(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  

}