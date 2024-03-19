import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModule {
  String? uid;
  String? titleTask;
  String? description;
  String? category;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;
  int? remind;
  bool? isDone;

  TodoModule({
    this.uid,
    required this.titleTask,
    required this.description,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.isDone,
    required this.remind,
  });

  factory TodoModule.fromMap(DocumentSnapshot snap) {
    final map = snap.data() as Map<String, dynamic>;
    return TodoModule(
      uid: map['uid'],
      titleTask: map['titleTask'],
      description: map['description'],
      category: map['category'],
      date: map['date'],
      repeat: map['repeat'],
      remind: map['remind'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      isDone: map['isDone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'titleTask': titleTask,
      'description': description,
      'category': category,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
      'remind': remind,
      'isDone': isDone,
    };
  }
}
