import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/Module/todo.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';

class DBHelper {
  void storeDetailsOfTask(
      String title,
      String description,
      String category,
      String date,
      String startTime,
      String endTime,
      int remind,
      String repeat) async {
    var result = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(AuthServices().getUid())
        .collection(todoCollection)
        .add(
          TodoModule(
            titleTask: title,
            description: description,
            category: category,
            date: date,
            remind: remind,
            repeat: repeat,
            startTime: startTime,
            endTime: endTime,
            isDone: false,
          ).toMap(),
        );
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(todoCollection)
        .doc(result.id)
        .update({'uid': result.id});
    print(result.id);
  }

  static Future<void> updateTask({todoid, valueUpdate}) async {
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(AuthServices().getUid())
          .collection(todoCollection)
          .doc(todoid)
          .update({
        'isDone': valueUpdate,
      });
    } catch (e) {
      toast(e.toString(), Get.isDarkMode);
    }
  }

  static Future<void> deleteTask({todoid}) async {
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(AuthServices().getUid())
          .collection(todoCollection)
          .doc(todoid)
          .delete();
    } catch (e) {
      toast(e.toString(), Get.isDarkMode);
    }
  }
}
