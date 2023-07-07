import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cec_connect/Screen/HomeScreen.dart';
import 'package:cec_connect/Screen/home2.dart';
import 'package:cec_connect/model/skill_model.dart' as model;
import 'package:snippet_coder_utils/FormHelper.dart';

class Skill extends StatefulWidget {
  const Skill({Key? key}) : super(key: key);

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  final _auth = FirebaseAuth.instance;
  final linkedEditingController = new TextEditingController();

  List<dynamic> countries = [];
  List<dynamic> semester = [];
  List<dynamic> statesMasters = [];
  List<dynamic> states = [];
  List<dynamic> skill = [];

  String? countryId;
  String? stateId;
  String? semesterId;
  String? skillId;
  String? sem;
  String? linkedin;

  @override
  void initState() {
    super.initState();
    this.semester.add({"Id": 1, "Label": "Semester 1"});
    this.semester.add({"Id": 2, "Label": "Semester 2"});
    this.semester.add({"Id": 3, "Label": "Semester 3"});
    this.semester.add({"Id": 4, "Label": "Semester 4"});
    this.semester.add({"Id": 5, "Label": "Semester 5"});
    this.semester.add({"Id": 6, "Label": "Semester 6"});
    this.semester.add({"Id": 7, "Label": "Semester 7"});
    this.semester.add({"Id": 8, "Label": "Semester 8"});

    this.countries.add({"id": 1, "label": "CSE"});
    this.countries.add({"id": 2, "label": "ECE"});
    this.countries.add({"id": 3, "label": "EEE"});
    this.countries.add({"id": 4, "label": "MCA"});
    this.skill.add({"iD": 1, "LabeL": "Sports"});

    this.statesMasters = [
      {"ID": 5, "Name": "C", "ParentId": 1},
      {"ID": 6, "Name": "D", "ParentId": 1},
      {"ID": 7, "Name": "A", "ParentId": 2},
      {"ID": 8, "Name": "B", "ParentId": 2},
      {"ID": 9, "Name": "E", "ParentId": 3},
      {"ID": 10, "Name": "F", "ParentId": 3},
      {"ID": 11, "Name": "M", "ParentId": 4},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final linked_in = TextFormField(
      autofocus: false,
      controller: linkedEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid id(example:https://www.linkedin.com/in/nibin-psreenivas-426678253/)");
        }
        return null;
      },
      onSaved: (value) {
        linkedEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(IconData(0xe043, fontFamily: 'MaterialIcons')),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "https://www.linkedin.com/in/username/",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          )),
    );
    final SignButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(40),
      color: Colors.blue[700],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn();
        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    var children2 = <Widget>[
      SizedBox(
          height: 120,
          child: Image.asset(
            "lib/asset/logo.jpg",
            fit: BoxFit.contain,
          )),
      SizedBox(height: 35),
      Text(
        "CLASS DETAILS",
        style: TextStyle(
            color: Color.fromARGB(255, 79, 74, 74),
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      SizedBox(
          width: 800.0,
          child: FormHelper.dropDownWidget(
              context, "Select Semester", this.semesterId, this.semester,
              (onChangedVal) {
            this.semesterId = onChangedVal;
            print("Selected Semester : $onChangedVal");
            sem = onChangedVal;
          }, (onValidateVal) {
            if (onValidateVal == null) {
              return 'Please Select Semester';
            }
            setState(() {});
            return null;
          },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 40,
              optionValue: "Id",
              optionLabel: "Label",
              paddingLeft: 0.0,
              paddingRight: 0.0)),
      SizedBox(height: 5),
      SizedBox(
          width: 800.0,
          child: FormHelper.dropDownWidget(
              context, "Select Branch", this.countryId, this.countries,
              (onChangedVal) {
            this.countryId = onChangedVal;
            print("Selected Branch : $onChangedVal");

            this.states = this
                .statesMasters
                .where(
                  (stateItem) =>
                      stateItem["ParentId"].toString() ==
                      onChangedVal.toString(),
                )
                .toList();
            this.stateId = null;
          }, (onValidateVal) {
            if (onValidateVal == null) {
              return 'Please Select Branch';
            }
            setState(() {});
            return null;
          },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 40,
              optionValue: "id",
              optionLabel: "label",
              paddingLeft: 0.0,
              paddingRight: 0.0)),
      SizedBox(height: 5),
      FormHelper.dropDownWidget(
          context, "Select Division", this.stateId, this.states,
          (onChangedVal) {
        this.stateId = onChangedVal;
        print("Selected Division : $onChangedVal");
      }, (onValidate) {
        return null;
      },
          borderColor: Theme.of(context).primaryColor,
          borderFocusColor: Theme.of(context).primaryColor,
          borderRadius: 40,
          optionValue: "ID",
          optionLabel: "Name",
          paddingLeft: 0.0,
          paddingRight: 0.0),
      SizedBox(height: 25),
      Text(
        "SKILLS AND INTERESTS",
        style: TextStyle(
            color: Color.fromARGB(255, 78, 73, 73),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      SizedBox(
          width: 800.0,
          child: FormHelper.dropDownWidget(
              context, "Select Skill", this.skillId, this.skill,
              (onChangedVal) {
            this.skillId = onChangedVal;
            print("Selected Semester : $onChangedVal");
          }, (onValidateVal) {
            if (onValidateVal == null) {
              return 'Please Select Skill';
            }
            return null;
          },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 40,
              optionValue: "iD",
              optionLabel: "LabeL",
              paddingLeft: 0.0,
              paddingRight: 0.0)),
      SizedBox(height: 25),
      Text(
        "Enter your linked in",
        style: TextStyle(
            color: Color.fromARGB(255, 78, 73, 73),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 25),
      linked_in,
      SizedBox(height: 25),
      SignButton,
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(36.0),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children2,
                ))),
          )),
        ));
  }

  void signIn() async {
    User? user = _auth.currentUser;
    model.SkillModel skillModel = model.SkillModel(
        Class: countryId,
        sem: sem,
        Division: stateId,
        linkedin: linkedEditingController.text,
        skill: skillId);

    var db = FirebaseFirestore.instance.collection("student");

    await db.doc(user?.uid).collection("class").add(skillModel.toJson());

    Fluttertoast.showToast(msg: "Account created Successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen2()),
        (route) => false);
  }
}
