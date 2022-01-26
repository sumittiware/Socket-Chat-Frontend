import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socket_chat/model/chat.dart';
import 'package:socket_chat/screens/joinPage.dart';
import 'package:socket_chat/services/socket.dart';
import 'package:socket_chat/textcontroller.dart';
import 'package:socket_chat/widget/newMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _controller = MyTextController();
  Box<Chat> chatBox;
  bool boxInit = false;

  @override
  void initState() {
    Hive.openBox<Chat>("messages").then((box) {
      chatBox = box;
      print("Stored values");
      print(chatBox.length.toString());
      setState(() {
        boxInit = true;
      });
    });
    super.initState();
  }

  String _enteredMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: (!boxInit)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : WatchBoxBuilder(
                      box: chatBox,
                      builder: (_, box) {
                        return ListView(
                          // reverse: true,
                          children: [
                            ...List.generate(
                                box.values.length,
                                (index) => NewMessege(
                                      isMe: box.values.elementAt(index).user ==
                                          username,
                                      message: box.values.elementAt(index).text,
                                      username:
                                          box.values.elementAt(index).user,
                                    ))
                          ],
                        );
                      })),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Send Message',
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  },
                ),
              )),
              // UserImagePicker(_pickedImage),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FloatingActionButton(
                    elevation: 0,
                    child: Icon(Icons.send),
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      FlutterSocket.sendMessage(text: _enteredMessage);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
