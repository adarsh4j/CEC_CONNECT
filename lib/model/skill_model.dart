import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cec_connect/resources/StorageMethods.dart';

class SkillModel {
  // final String? uid;
  // final String? email;
  // final String? firstName;
  // final String? secondName;
  // final String? phone;
  final String? sem;
  final String? Class;
  final String? Division;
  final String? linkedin;
  final String? skill;
  // final String? PhotoUrl;

  const SkillModel({
    //required this.uid,
    // required this.email,
    // required this.firstName,
    // required this.secondName,
    // required this.phone,
    required this.sem,
    required this.Class,
    required this.Division,
    required this.linkedin,
    required this.skill,
    // required this.PhotoUrl
  });

  static SkillModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SkillModel(
        sem: snapshot['sem'],
        Class: snapshot['Class'],
        Division: snapshot['Division'],
        linkedin: snapshot['linkedin'],
        skill: snapshot['skill']);
  }

  Map<String, dynamic> toJson() => {
        'sem': sem,
        'Class': Class,
        'Division': Division,
        'linkedin': linkedin,
        'skill': skill,

        // 'photoUrl': PhotoUrl
      };
}
