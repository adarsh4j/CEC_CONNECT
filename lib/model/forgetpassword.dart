import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cec_connect/resources/StorageMethods.dart';

class forgot {
  String? email;
  final String uid;

  forgot({
    this.email,
    required this.uid,
  });

  static forgot fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return forgot(
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
