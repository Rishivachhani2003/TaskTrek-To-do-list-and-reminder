import 'package:cloud_firestore/cloud_firestore.dart';

class Udata {
  final String? uid;
  String? name;
  String? email;
  // String? profileImage;
  String? password;

  Udata({
    required this.uid,
    required this.name,
    required this.email,
    // this.profileImage,
    required this.password,
  });

  factory Udata.fromMap(DocumentSnapshot snap) {
    final map = snap.data() as Map<String, dynamic>;
    return Udata(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      // profileImage: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      // 'profileImage': profileImage,
    };
  }
}
