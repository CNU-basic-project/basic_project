import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  User? loggedUser;

  FirebaseRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  User? getUser() {
    return loggedUser;
  }

  Future<bool> signUp(String userName, String userEmail, String userPassword, Function render) async {
    try {
      final UserCredential newUser =
      await firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      await firebaseFirestore
          .collection('user')
          .doc(newUser.user!.uid)
          .set({'userName': userName, 'email': userEmail, 'profile': ''});

      if (newUser.user != null) {
        loggedUser = newUser.user;
        render();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signIn(String userEmail, String userPassword, Function render) async {
    try {
      final UserCredential newUser =
      await firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      if (newUser.user != null) {
        loggedUser = newUser.user;
        render();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  bool signOut(Function render) {
    if (loggedUser == null) return false;
    firebaseAuth.signOut();
    loggedUser = null;
    render();
    return true;
  }

  void initializeUser(Function render) {
    firebaseAuth.authStateChanges().listen((user) {
      loggedUser = user;
      render();
    });
  }
}