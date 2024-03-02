// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/database_services.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentReference _documentReference;
  // _firestore.collection(userCollection).doc();

  //LOGIN

  Future<String> login(String emailAddress, String password) async {
    String res = 'Some Error...';

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      DatabaseServices().fetchUserData(
        _auth.currentUser!.uid,
      );

      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        res = "No User Found for this email";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        res = "Wrong Password for that email";
      } else if (e.code == 'invalid-email') {
        print('This email is invalid.');
        res = 'This email is invalid.';
      }
    }

    return res;
  }

  //Sign Up

  Future<String> signUp(
      String emailAddress, String name, String password) async {
    String res = 'Some Error...';

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      DatabaseServices().storeNameOfUser(
        _auth.currentUser!.uid,
        name,
        emailAddress,
        password,
      );

      res = 'Success';
      DatabaseServices().fetchUserData(
        _auth.currentUser!.uid,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        res = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        print('This email is invalid.');
        res = 'This email is invalid.';
      }
    } catch (e) {
      print(e);
    }

    return res;
  }

  //Sign Out

  Future<String> signOut() async {
    String res = 'Some error...';

    try {
      await FirebaseAuth.instance.signOut();
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        res = "No User Found for this email";
      } else if (e.code == 'invalid-email') {
        print('This email is invalid.');
        res = 'This email is invalid.';
      }
    }

    return res;
  }

  //Reset Password

  Future<String> resetPassword(String email) async {
    String res = 'Some Error...';

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      res = 'Success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }

    return res;
  }

  // delete userdata

  Future<void> deleteUserData() async {
    try {
      _documentReference =
          _firestore.collection(userCollection).doc(AuthServices().getUid());
      _documentReference.delete();
      // _firestore
      // .collection(userCollection)
      // .doc(AuthServices().getUid())
      // .collection(todoCollection);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // delete account

  Future<String> deleteAccount() async {
    String res = 'Some error...';

    try {
      await FirebaseAuth.instance.currentUser!.delete();
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        res = "No User Found for this email";
      } else if (e.code == 'requires-recent-login') {
        print('You requires recent login');
        res = 'You requires recent login';
      }
    }

    return res;
  }

  getUid() {
    return _auth.currentUser!.uid;
  }
}
