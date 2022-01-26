import 'package:socket_chat/model/chat.dart';
import 'package:socket_chat/screens/joinPage.dart';
import 'package:socket_chat/services/hiveService.dart';
import 'package:socket_io_client/socket_io_client.dart';

class FlutterSocket {
  static Socket socket;

  static void initConnection() {
    try {
      socket = io("http://192.168.43.220:5000", <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });
      socket.connect().onError((data) => print("Connection Error occured!!"));
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('reply', (data) {
        print(data);
        HiveServices().addMessegeToDb(Chat.fromJSON(data));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static void sendMessage({String text}) {
    socket.emit("message", {"message": text, "username": username});
  }
}
