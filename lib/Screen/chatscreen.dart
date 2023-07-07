import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  final List messages;

  const chatscreen({super.key, required this.messages});

  @override
  State<chatscreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<chatscreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return ListView.separated(
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]["isUserMessage"]
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 20 : 0),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 0 : 20),
                      ),
                      color: widget.messages[index]["isUserMessage"]
                          ? Color.fromARGB(255, 255, 144, 144)
                          : Color.fromARGB(255, 252, 194, 194),
                    ),
                    constraints: BoxConstraints(minWidth: w * 2 / 3),
                    child: Text(widget.messages[index]["message"].text.text[0]),
                  ),
                )
              ],
            ),
          );
        }),
        separatorBuilder: ((context, index) => const Padding(
              padding: EdgeInsets.only(top: 0),
            )),
        itemCount: widget.messages.length);
  }
}
