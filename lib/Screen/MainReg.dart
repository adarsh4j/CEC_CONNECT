import 'package:flutter/material.dart';
import 'package:cec_connect/Screen/TeacherReg.dart';
import 'package:cec_connect/Screen/StudentReg.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    final studentButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 252, 69, 104),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistrationScreen(),
              ));
        },
        child: Text(
          "STUDENT",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final teacherButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 252, 69, 104),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherScreen(),
              ));
        },
        child: Text(
          "TEACHER",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 150,
                        child: Image.asset(
                          "lib/asset/logo1.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 30),
                    Text(
                      "REGISTER AS A STUDENT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    studentButton,
                    SizedBox(height: 50),
                    Text(
                      "REGISTER AS A TEACHER",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    teacherButton,
                  ],
                )),
              )),
        )),
      ),
    );
  }
}
