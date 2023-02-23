import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'emoji.g.dart';

@HiveType(typeId: 1)
class Emoji {
  @HiveField(0)
  int number;
  @HiveField(1)
  String name;
  @HiveField(2)
  String url;
  @HiveField(3)
  Color color;
  Emoji(
      {required this.number,
      required this.name,
      required this.url,
      required this.color});
}
