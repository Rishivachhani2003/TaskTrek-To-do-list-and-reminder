import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_riverpod/Module/todo.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';

class TaskServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void storeDetailsOfTask(
      String title,
      String description,
      String category,
      String date,
      String startTime,
      String endTime,
      int remind,
      String repeat) async {
    var result = await _firestore
        .collection(userCollection)
        .doc(AuthServices().getUid())
        .collection(todoCollection)
        .add(
          TodoModule(
            titleTask: title,
            description: description,
            category: category,
            date: date,
            startTime: startTime,
            endTime: endTime,
            remind: remind,
            repeat: repeat,
            isDone: false,
          ).toMap(),
        );
    await _firestore
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(todoCollection)
        .doc(result.id)
        .update({'uid': result.id});
    print(result.id);
  }

  Future<void> updateTask({todoid, bool? valueUpdate}) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(AuthServices().getUid())
          .collection(todoCollection)
          .doc(todoid)
          .update({
        'isDone': valueUpdate,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> deleteTask({todoid}) async {
    try {
      _firestore
          .collection(userCollection)
          .doc(AuthServices().getUid())
          .collection(todoCollection)
          .doc(todoid)
          .delete();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
