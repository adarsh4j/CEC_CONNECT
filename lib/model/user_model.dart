import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cec_connect/resources/StorageMethods.dart';

class UserModel {
  final String uid;
  final String? email;
  final String firstName;
  final String? secondName;
  final String? phone;
  final String? sem;
  final String? Class;
  final String? Division;
  final String? PhotoUrl;
  final String? role;
  final String? skill;
  final String? linkedin;
  final String? github;

  const UserModel(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.secondName,
      required this.phone,
      required this.sem,
      required this.Class,
      required this.Division,
      required this.PhotoUrl,
      required this.role,
      required this.skill,
      required this.linkedin,
      required this.github});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot['uid'],
        email: snapshot['email'],
        firstName: snapshot['firstName'],
        secondName: snapshot['secondName'],
        phone: snapshot['phone'],
        sem: snapshot['sem'],
        Class: snapshot['Class'],
        Division: snapshot['Division'],
        PhotoUrl: snapshot['photoUrl'],
        role: snapshot['role'],
        skill: snapshot['skill'],
        linkedin: snapshot['linkedin'],
        github: snapshot['github']);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'secondName': secondName,
        'phone': phone,
        'sem': sem,
        'Class': Class,
        'Division': Division,
        'photoUrl': PhotoUrl,
        'role': role,
        'skill': skill,
        'linkedin': linkedin,
        'github': github
      };
}
