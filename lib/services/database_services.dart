import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/Module/user.dart' as module;

class DatabaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void storeNameOfUser(
      String uid, String name, String email, String password) async {
    await _firestore.collection(userCollection).doc(uid).set(
          module.Udata(
            uid: uid,
            name: name,
            email: email,
            password: password,
          ).toMap(),
        );
  }

  //
  Future<module.Udata?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return module.Udata.fromMap(userSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  //bug store code
  Future<String> addBugReport(String bugDescription) async {
    String res = 'Error...';
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc('bugs')
          .collection(AuthServices().getUid())
          .add({
        'data': bugDescription,
        'timestamp':
            FieldValue.serverTimestamp(), // You can add a timestamp if needed
      });
      res = 'Success';
      print('Bug report added to Firestore');
    } catch (e) {
      print('Error adding bug report to Firestore: $e');
    }
    return res;
  }

  //Support request
  Future<String> addSupportRequest(
    String name,
    String email,
    String message,
  ) async {
    String res = 'Error..';
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc('support')
          .collection(AuthServices().getUid())
          .add({
        'Name': name,
        'Email': email,
        'Message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      res = 'Success';
    } catch (e) {
      print('Error adding support request to Firestore: $e');
    }
    return res;
  }
}
