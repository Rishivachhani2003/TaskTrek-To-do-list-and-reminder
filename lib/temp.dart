// // // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations, unused_import, unused_local_variable

// // ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, use_build_context_synchronously, avoid_print, prefer_final_fields

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:to_do_riverpod/Module/taskcontroller.dart';
// import 'package:to_do_riverpod/consts/constants.dart';
// import 'package:to_do_riverpod/services/auth_services.dart';
// import 'package:to_do_riverpod/services/local_notification.dart';
// import 'package:intl/intl.dart';
// import 'package:to_do_riverpod/screens/new_task_screen.dart';
// import 'package:to_do_riverpod/widget/dialogs/delete_note_dialog.dart';
// import 'package:to_do_riverpod/widget/drawer/navigation.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late NotifyHelper? _notifyHelper;
//   bool notificationScheduled = false;

//   bool isBannerLoaded = false;
//   late BannerAd bannerAd;

//   DateTime today = DateTime.now();
//   final TaskController _taskController = Get.put(TaskController());

//   @override
//   void initState() {
//     super.initState();
//     // initializeBannerAd();
//     _initializeNotification();
//     _taskController.getTasks();
//   }

//   void _initializeNotification() {
//     _notifyHelper = NotifyHelper();
//     _notifyHelper!.initializeNotification();
//   }

//   String convertTimeTo24HourFormat(String time) {
//     final inputFormat = DateFormat('h:mm a');
//     final outputFormat = DateFormat('HH:mm');

//     final dateTime = inputFormat.parse(time);
//     return outputFormat.format(dateTime);
//   }

//   Future<void> _onRefresh() async {
//     _taskController.getTasks();
//   }

//   // void scheduleNotificationOnce() {
//   //   if (!notificationScheduled) {
//   //     _notifyHelper?.scheduledNotification(
//   //     );

//   //     notificationScheduled = true; // Set the flag to true after scheduling
//   //   }
//   // }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // scheduleNotificationOnce(); // Call the method when dependencies change
//   }

//   initializeBannerAd() async {
//     bannerAd = BannerAd(
//       size: AdSize.banner,
//       // adUnitId: 'ca-app-pub-6091503707312070/1559466355',
//       adUnitId: 'ca-app-pub-3940256099942544/9214589741',
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           setState(() {
//             isBannerLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           isBannerLoaded = false;
//           Fluttertoast.showToast(msg: error.toString());
//         },
//       ),
//       request: AdRequest(),
//     );
//     bannerAd.load();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       drawer: NavigationHomeScreen(),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         toolbarHeight: 70,
//         elevation: 10,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "TaskTrek",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               "${DateFormat("EEEEE, dd MMMM").format(DateTime.now())}",
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(CupertinoIcons.bell),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(CupertinoIcons.search),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _onRefresh,
//         child: Column(
//           children: [
//             Expanded(
//               child: Obx(
//                 () {
//                   if (_taskController.taskList.isEmpty) {
//                     return Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             "assets/images/task.svg",
//                             color: Colors.purple.withOpacity(0.5),
//                             height: 90,
//                             semanticsLabel: 'Task',
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 10),
//                             child: Text(
//                               'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _taskController.taskList.length,
//                       itemBuilder: (context, index) {
//                         // DocumentSnapshot data = snapshot.data!.docs[index];
//                         Color categoryColor = Colors.white;

//                         var task = _taskController.taskList[index];
//                         final getCategory = task.category.toString();

//                         switch (getCategory) {
//                           case 'Learning':
//                             categoryColor = Colors.green;
//                             break;
//                           case 'Working':
//                             categoryColor = Colors.blue.shade700;
//                             break;
//                           case 'General':
//                             categoryColor = Colors.amber.shade700;
//                             break;
//                         }

//                         DateFormat format = DateFormat("dd/MM/yyyy");
//                         String _selectedDate = format.format(today).toString();

//                         if (task.repeat == 'Daily' ||
//                             task.date == _selectedDate ||
//                             (task.repeat == 'Weekly' &&
//                                 format
//                                             .parse(_selectedDate)
//                                             .difference(format
//                                                 .parse(task.date.toString()))
//                                             .inDays %
//                                         7 ==
//                                     0) ||
//                             (task.repeat == 'Monthly' &&
//                                 format.parse(task.date.toString()).day ==
//                                     format.parse(_selectedDate).day)) {
//                           try {
//                             String time12HourFormat = task.startTime.toString();
//                             String time24HourFormat =
//                                 convertTimeTo24HourFormat(time12HourFormat);
//                             print('Time in 24-hour format: $time24HourFormat');

//                             _notifyHelper!.scheduledNotification(
//                               int.parse(time24HourFormat.split(':')[0]),
//                               int.parse(time24HourFormat.split(':')[1]),
//                               task.titleTask.toString(),
//                               task.description.toString(),
//                               task.remind!,
//                               task.repeat.toString(),
//                               task.date.toString(),
//                             );
//                           } catch (e) {
//                             print('Error parsing time: $e');
//                           }
//                         }

//                         // print(task.isDone);

//                         //  else {
//                         // Container();
//                         // }

//                         return AnimationConfiguration.staggeredList(
//                           position: index,
//                           duration: const Duration(milliseconds: 1375),
//                           child: SlideAnimation(
//                             child: FadeInAnimation(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 13, right: 13, top: 8, bottom: 8),
//                                 child: Slidable(
//                                   endActionPane: ActionPane(
//                                     motion: StretchMotion(),
//                                     children: [
//                                       SlidableAction(
//                                         onPressed: (context) async {
//                                           final shouldDelete =
//                                               await showDeleteNoteDialog(
//                                                   context);
//                                           if (shouldDelete) {
//                                             _taskController.deleteTask(
//                                                 task.uid.toString());
//                                           }
//                                         },
//                                         icon: Icons.delete,
//                                         backgroundColor: Colors.red,
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Container(
//                                     margin: EdgeInsets.symmetric(vertical: 5),
//                                     width: double.infinity,
//                                     height: 120,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: categoryColor,
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(12),
//                                               bottomLeft: Radius.circular(12),
//                                             ),
//                                           ),
//                                           width: 30,
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: 20,
//                                             ),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 ListTile(
//                                                   contentPadding:
//                                                       EdgeInsets.zero,
//                                                   title: Text(
//                                                     task.titleTask.toString(),
//                                                     maxLines: 1,
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                       decoration: task.isDone!
//                                                           ? TextDecoration
//                                                               .lineThrough
//                                                           : null,
//                                                     ),
//                                                   ),
//                                                   subtitle: Text(
//                                                     task.description.toString(),
//                                                     maxLines: 1,
//                                                     style: TextStyle(
//                                                       fontSize: 15,
//                                                       decoration: task.isDone!
//                                                           ? TextDecoration
//                                                               .lineThrough
//                                                           : null,
//                                                     ),
//                                                   ),
//                                                   trailing: Transform.scale(
//                                                     scale: 1.5,
//                                                     child: Checkbox(
//                                                         activeColor: Colors
//                                                             .blue.shade800,
//                                                         value: task.isDone!,
//                                                         shape: CircleBorder(),
//                                                         onChanged: (value) {
//                                                           _taskController
//                                                               .markAsCompleted(
//                                                                   task.uid
//                                                                       .toString(),
//                                                                   value!);
//                                                         }),
//                                                   ),
//                                                 ),
//                                                 Transform.translate(
//                                                   offset: Offset(0, -12),
//                                                   child: Container(
//                                                     child: Column(
//                                                       children: [
//                                                         Divider(
//                                                           thickness: 1.5,
//                                                           color: Colors
//                                                               .grey.shade200,
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Text(task.date
//                                                                 .toString()),
//                                                             Text(task.startTime
//                                                                 .toString()),
//                                                             Text(task.endTime
//                                                                 .toString()),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       // ),
//       // bottomNavigationBar: isBannerLoaded == true
//       //     ? SizedBox(
//       //         height: 70,
//       //         child: AdWidget(
//       //           ad: bannerAd,
//       //         ),
//       //       )
//       //     : Container(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (c) => NewTaskScreen()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
