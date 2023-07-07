import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cec_connect/utils/globalvar.dart';
import 'dart:math';

class spga extends StatefulWidget {
  const spga({super.key});

  @override
  State<spga> createState() => _spgaState();
}

class _spgaState extends State<spga> {
  late String lectureName;
  int lectureCredit = 1;
  double lectureLetterValue = 10;
  late List<Lecture> allLectures;
  var formKey = GlobalKey<FormState>();
  late double gpa;
  static int counter = 0;

  @override
  void initState() {
    super.initState();
    allLectures = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text("ktu SGPA")),
          backgroundColor: Color.fromARGB(255, 252, 69, 104),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 252, 69, 104),
          foregroundColor: Colors.white,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
            }
          },
          child: Icon(Icons.add),
        ),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Subject Name",
                              hintText: "Please enter a Subject name",
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value!.length > 0) {
                              return null;
                            } else
                              return "Please a validate subject name";
                          },
                          onSaved: (newValue) {
                            lectureName = newValue!;
                            setState(() {
                              allLectures.add(Lecture(lectureName,
                                  lectureLetterValue, lectureCredit));
                              gpa = 0.0;
                              calculateGpa();
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: lectureCredits(),
                                  value: lectureCredit,
                                  onChanged: (selectedCredit) {
                                    setState(() {
                                      lectureCredit = selectedCredit! as int;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: lectureLetterValues(),
                                  value: lectureLetterValue,
                                  onChanged: (value) {
                                    lectureLetterValue = value!;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ))),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Expanded(
                child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemBuilder: _createListItems,
                      itemCount: allLectures.length,
                    ))),
            Container(
              //padding: EdgeInsets.only( {double left=10.0}),
              height:50,
              width: 100,
              decoration: BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color.fromARGB(255, 252, 69, 104),
                  width: 3,
                ),
              ),
              //color: Colors.blue[100],
              margin: EdgeInsets.symmetric(vertical: 80),
              //height: 70,
              child: Center(
                  child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "SGPA : ",
                      style: TextStyle(fontSize: 23, color: Colors.black)),
                  TextSpan(
                      text:
                          allLectures.length == 0 ? "Enter a SUBJECT" : "$gpa",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ]),
              )),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> lectureCredits() {
    List<DropdownMenuItem<int>> credits = [];
    for (int i = 1; i <= 11; i++) {
      credits.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Credit"),
      ));
    }
    return credits;
  }

  List<DropdownMenuItem<double>> lectureLetterValues() {
    List<DropdownMenuItem<double>> letters = [];

    letters.add(DropdownMenuItem(
        child: Text(
          "S",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 10));
    letters.add(DropdownMenuItem(
        child: Text(
          "A+",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 9));

    letters.add(DropdownMenuItem(
        child: Text(
          "A",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 8.5));
    letters.add(DropdownMenuItem(
        child: Text(
          "B+",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 8));
    letters.add(DropdownMenuItem(
        child: Text(
          "B",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 7.5));
    letters.add(DropdownMenuItem(
        child: Text(
          "C+",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 7));
    letters.add(DropdownMenuItem(
        child: Text(
          "C",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 6.5));
    letters.add(DropdownMenuItem(
        child: Text(
          "D+",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 6));
    letters.add(DropdownMenuItem(
        child: Text(
          "D",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 5.5));
    letters.add(DropdownMenuItem(
        child: Text(
          "P",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 5));
    letters.add(DropdownMenuItem(
        child: Text(
          "F",
          style: TextStyle(fontSize: 20.0),
        ),
        value: 0));

    return letters;
  }

  Widget _createListItems(BuildContext context, int index) {
    Color randomColor = createRandomColor();
    counter++;
    return Dismissible(
      key: Key(counter.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          allLectures.removeAt(index);
          calculateGpa();
        });
      },
      child: Card(
        child: ListTile(
          leading: Icon(
            Icons.book,
            size: 36,
            color: createRandomColor(),
          ),
          title: Text(allLectures[index].name),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
          ),
          subtitle: Text(allLectures[index].credit.toString() + " credits"),
        ),
      ),
    );
  }

  void calculateGpa() {
    double totalGrade = 0;
    double totalCredit = 0;

    for (var item in allLectures) {
      var credit = item.credit;
      var letterValue = item.letterValue;

      totalGrade = totalGrade + (letterValue * credit);
      totalCredit += credit;
    }
    gpa = totalGrade / totalCredit;
  }

  Color createRandomColor() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

class Lecture {
  String name;
  double letterValue;
  int credit;

  Lecture(this.name, this.letterValue, this.credit);
}
