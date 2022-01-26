import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_chat/model/chat.dart';
import 'package:socket_chat/screens/joinPage.dart';
import 'package:socket_chat/services/hiveService.dart';
import 'package:socket_chat/services/socket.dart';
import 'package:socket_chat/textcontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ChatAdapter());
  FlutterSocket.initConnection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socket Chat app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JoinChat(),
    );
  }
}
