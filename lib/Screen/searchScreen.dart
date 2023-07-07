import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cec_connect/Screen/SkillProfile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowusers = false;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 252, 69, 104),
            title: Form(
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                    labelText: 'Enter the skill here', fillColor: Colors.white
                ),
                onFieldSubmitted: (String _) {
                  setState(() {
                    isShowusers = true;
                  });
                  print(_);
                },
              ),
            ),
          ),
          body: Container(
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('student')
                    .where('skill', isEqualTo: searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen3(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid'],
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 241, 246, 249),
                            backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic).docs[index]
                                    ['photoUrl']),
                          ),
                          title: Text(
                              (snapshot.data! as dynamic).docs[index]['email']),
                          subtitle: Row(
                            children: [
                              Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['firstName'],
                              ),
                              Text(' '),
                              Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['secondName'],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          )),
    );
  }
}
