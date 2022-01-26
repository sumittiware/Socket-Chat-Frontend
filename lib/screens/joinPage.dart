import 'package:flutter/material.dart';
import 'package:socket_chat/screens/chatScreen.dart';

String username;

class JoinChat extends StatelessWidget {
  const JoinChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Socket Chat"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: TextField(
                onChanged: (val) {
                  username = val;
                },
                decoration: InputDecoration(hintText: "Enter Username"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ChatScreen()));
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
