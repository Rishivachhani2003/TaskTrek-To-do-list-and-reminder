// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations, unused_import, unused_local_variable

// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_riverpod/consts/constants.dart';
import 'package:to_do_riverpod/services/auth_services.dart';
import 'package:to_do_riverpod/services/task_services.dart';
import 'package:intl/intl.dart';
import 'package:to_do_riverpod/view/new_task_screen.dart';
import 'package:to_do_riverpod/widget/dialogs/delete_note_dialog.dart';
import 'package:to_do_riverpod/widget/drawer/navigation.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: NavigationHomeScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        toolbarHeight: 70,
        elevation: 10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Taskify",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${DateFormat("EEEEE, dd MMMM").format(DateTime.now())}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(userCollection)
            .doc(AuthServices().getUid())
            .collection(todoCollection)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.hasError.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.data!.docs.length == 0) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/task.svg",
                    color: Colors.purple.withOpacity(0.5),
                    height: 90,
                    semanticsLabel: 'Task',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                Color categoryColor = Colors.white;
                final getCategory = data['category'];
                switch (getCategory) {
                  case 'Learning':
                    categoryColor = Colors.green;
                    break;
                  case 'Working':
                    categoryColor = Colors.blue.shade700;
                    break;
                  case 'General':
                    categoryColor = Colors.amber.shade700;
                    break;
                }
                return Padding(
                  padding:
                      EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          autoClose: false,
                          onPressed: (context) async {
                            final shouldDelete =
                                await showDeleteNoteDialog(context);
                            if (shouldDelete) {
                              setState(() {
                                TaskServices().deleteTask(todoid: data['uid']);
                              });
                            }
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: categoryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            width: 30,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      data['titleTask'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: data['isDone']
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    subtitle: Text(
                                      data['description'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 15,
                                        decoration: data['isDone']
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    trailing: Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                          activeColor: Colors.blue.shade800,
                                          value: data['isDone'],
                                          shape: CircleBorder(),
                                          onChanged: (value) {
                                            setState(() {
                                              TaskServices().updateTask(
                                                todoid: data['uid'],
                                                valueUpdate: value,
                                              );
                                            });
                                          }),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, -12),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Divider(
                                            thickness: 1.5,
                                            color: Colors.grey.shade200,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(data['date'].toString()),
                                              Text(data['startTime']),
                                              Text(data['endTime']),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => NewTask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
