import 'package:cec_connect/Screen/ProfileScreen.dart';
import 'package:cec_connect/Screen/github.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cec_connect/utils/globalvar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  late PageController pageController;
  int _page = 0;
  bool isUser = false;
  final _auth = FirebaseAuth.instance;
  var userData = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    Future isUser = auth();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Future<bool> auth() async {
    bool g = false;
    User? user = _auth.currentUser;
    var db = await FirebaseFirestore.instance
        .collection('student')
        .doc(user?.uid)
        .get();
    userData = db.data()!;
    if (userData['role'] == 'user') {
      g = true;
    }

    g = false;
    isUser = g;
    return g;
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: PageView(
            children: homeScreenItems2,
            controller: pageController,
            onPageChanged: onPageChanged,
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Color.fromARGB(255, 252, 69, 104),
            items: [
              Icon(
                Icons.home,
                color: _page == 0 ? Colors.white : Colors.white,
              ),
              Icon(
                IconData(0xf013d, fontFamily: 'MaterialIcons'),
                color: _page == 1 ? Colors.white : Colors.white,
              ),
              Icon(
                IconData(0xf522, fontFamily: 'MaterialIcons'),
                color: _page == 2 ? Colors.white : Colors.white,
              ),
              Icon(
                IconData(0xe44e, fontFamily: 'MaterialIcons'),
                color: _page == 3 ? Colors.white : Colors.white,
              ),
              Icon(
                IconData(0xe787, fontFamily: 'MaterialIcons'),
                color: _page == 4 ? Colors.white : Colors.white,
              ),
              Icon(
                IconData(0xf565, fontFamily: 'MaterialIcons'),
                color: _page == 5 ? Colors.white : Colors.white,
              ),
            ],
            onTap: navigationTapped,
          )),
    );
  }
}
