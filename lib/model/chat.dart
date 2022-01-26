import 'package:hive/hive.dart';
part 'chat.g.dart';

@HiveType(typeId: 0)
class Chat {
  @HiveField(0)
  String id;
  @HiveField(1)
  String text;
  @HiveField(2)
  String user;
  @HiveField(3)
  String date;

  Chat({this.id, this.text, this.user, this.date});

  Chat.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        user = json['user'],
        date = json['user'];

  Map<String, dynamic> toJson() =>
      {"id": id, "text": text, "user": user, "date": date};
}
