import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/controller/controller.dart';
import 'package:kelime_app/views/page/record_play_page.dart';
import 'package:kelime_app/views/page/select_emoji_page.dart';

import '../../models/day_model.dart';

class Day extends StatefulWidget {
  DayModel dayModel;

  Day({Key? key, required this.dayModel}) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return !widget.dayModel.isRecorded
        ? TextButton(
            child: Text(
              widget.dayModel.day.toString(),
              style: TextStyle(color: checkDate() ? Colors.black : Colors.grey),
            ),
            onPressed: () async {
              if (!widget.dayModel.isRecorded && checkDate()) {
                Get.to(
                  SelectEmojiPage(
                    dayModel: widget.dayModel,
                  ),
                );
              }
            },
          )
        : InkWell(
            onTap: () => Get.to(
                  () => RecordPlayPage(
                    isRecordFinished: true,
                    dayModel: widget.dayModel,
                  ),
                ),
            child: Image.asset(
              widget.dayModel.emoji.url,
              width: 30,
              height: 30,
            ));
  }

  bool checkDate() {
    String day = "";
    String month = "";

    if (widget.dayModel.day.length == 1) {
      day = "0${widget.dayModel.day}";
    } else {
      day = widget.dayModel.day;
    }
    if (widget.dayModel.month.toString().length == 1) {
      month = "0${widget.dayModel.month}";
    } else {
      month = widget.dayModel.month.toString();
    }
    DateTime checkDate = DateTime.parse("${widget.dayModel.year}-$month-$day");

    if (checkDate.isBefore(DateTime.now())) {
      return true;
    }
    return false;
  }

  checkEmoji() {}
}
