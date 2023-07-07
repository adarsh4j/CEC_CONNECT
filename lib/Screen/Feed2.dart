import 'package:cec_connect/Screen/ProfileScreen.dart';
import 'package:cec_connect/Screen/github.dart';
import 'package:cec_connect/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cec_connect/model/post.dart';
import 'package:cec_connect/widgets/post_NoIm.dart';
import 'package:cec_connect/widgets/post_card.dart';

class FeedScreen2 extends StatelessWidget {
  const FeedScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 252, 69, 104),
          centerTitle: true,
          title: Text('Notification')),
      drawer: NavigationDrawer(uid: FirebaseAuth.instance.currentUser!.uid),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notice').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard2(
              snap2: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  final String uid;
  const NavigationDrawer({Key? key, required this.uid}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  var userData = {};

  var classData = {};
  int postLen = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
      CircularProgressIndicator();
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('student')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => Drawer(
        //backgroundColor: Colors.transparent,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('student')
                    .where('uid', isEqualTo: widget.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return buildHeader(
                    urlImage: userData['photoUrl'],
                    name: userData['firstName'],
                    email: userData['email'],
                  );
                }),
            ListTile(
              title: const Text('Profile'),
              leading: Icon(
                IconData(0xf522, fontFamily: 'MaterialIcons'),
                color: Color.fromARGB(255, 255, 89, 123),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(
                IconData(0xe740, fontFamily: 'MaterialIcons'),
                color: Color.fromARGB(255, 255, 89, 123),
              ),
              title: const Text('CEC website'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WebViewApp('https://ceconline.edu/')));
              },
            ),
          ],
        ), // Populate the Drawer in the next step.
      );
}

Widget buildHeader(
        {required String urlImage,
        required String name,
        required String email}) =>
    InkWell(
      child: Container(
        height: 130,
        color: Color.fromARGB(255, 255, 89, 123),
        child: Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(urlImage)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
