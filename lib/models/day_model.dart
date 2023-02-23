import 'package:hive/hive.dart';

import 'emoji.dart';

part 'day_model.g.dart';

@HiveType(typeId: 0)
class DayModel extends HiveObject {
  @HiveField(0)
  bool isRecorded;
  @HiveField(1)
  String day;
  @HiveField(2)
  int month;
  @HiveField(3)
  String year;
  @HiveField(4)
  String? imgPath;
  @HiveField(5)
  String? voicePath;
  @HiveField(6)
  Emoji emoji;
  @HiveField(7)
  String title;
  @HiveField(8)
  String userEmail;

  DayModel(
      {required this.day,
      required this.isRecorded,
      required this.month,
      required this.year,
      required this.emoji,
      required this.title,
      required this.userEmail,
      this.imgPath,
      this.voicePath});
}
