// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:to_do_riverpod/Module/todo.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/services/db_helper.dart';

class TaskController extends GetxController {
  final RxList<TodoModule> taskList = <TodoModule>[].obs;

  Future<void> getTasks() async {
    final QuerySnapshot<Map<String, dynamic>> tasks = await FirebaseFirestore
        .instance
        .collection(userCollection)
        .doc(AuthServices().getUid())
        .collection(todoCollection)
        .get();
    taskList.assignAll(tasks.docs.map((data) => TodoModule.fromMap(data)));

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection(userCollection)
    //     .doc(AuthServices().getUid())
    //     .collection(todoCollection)
    //     .get();

    // taskList.clear();

    // querySnapshot.docs.forEach((ele) {
    //   taskList.add(
    //     TodoModule(
    //       uid: ele['uid'],
    //       titleTask: ele['titleTask'],
    //       description: ele['description'],
    //       category: ele['category'],
    //       date: ele['date'],
    //       startTime: ele['startTime'],
    //       endTime: ele['endTime'],
    //       repeat: ele['repeat'],
    //       isDone: ele['isDone'],
    //       remind: ele['remind'],
    //     ),
    //   );
    // });
  }

  void deleteTask(String todoid) async {
    await DBHelper.deleteTask(todoid: todoid);
    getTasks();
  }

  void markAsCompleted(String todoid, bool isUp) async {
    await DBHelper.updateTask(todoid: todoid, valueUpdate: isUp);
  }
}
