import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_chat/model/chat.dart';

class HiveServices {
  init() async {
    Hive.openBox<Chat>("messeges");
  }

  addMessegeToDb(Chat chat) async {
    final box = await Hive.openBox<Chat>("messages");
    await box.add(chat).then((value) => print("saved"));
  }
}
