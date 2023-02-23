import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kelime_app/models/day_model.dart';
import 'package:kelime_app/views/page/select_emoji_page.dart';

import '../../controller/controller.dart';
import 'day_widget.dart';

class Month extends StatefulWidget {
  String monthName;
  int monthIndex;
  int monthDay;
  Month(
      {Key? key,
      required this.monthDay,
      required this.monthIndex,
      required this.monthName})
      : super(key: key);

  @override
  State<Month> createState() => _MonthState();
}

class _MonthState extends State<Month> {
  Controller controller = Get.put(Controller());
  List<DayModel> list = [];
  List<DayModel> filtered = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Box<DayModel> box = Hive.box('voice');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.year,
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      widget.monthName,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 50,
                    childAspectRatio: 2,
                    crossAxisCount: 7,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) {
                  return Center(child: Day(dayModel: checkIsRecorded(index)));
                },
                itemCount: widget.monthDay,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        );
      },
    );
  }

  checkIsRecorded(int index) {
    if (filtered.isNotEmpty) {
      for (var i = 0; i < filtered.length; i++) {
        if (filtered[i].day == (index + 1).toString() &&
            filtered[i].userEmail == _auth.currentUser!.email!) {
          return filtered[i];
        } else {}
      }
      return DayModel(
          day: (index + 1).toString(),
          isRecorded: false,
          month: widget.monthIndex,
          year: controller.year,
          emoji: emojiList[0],
          title: '',
          userEmail: '');
    } else {
      return DayModel(
        emoji: emojiList[0],
        day: (index + 1).toString(),
        isRecorded: false,
        month: widget.monthIndex,
        year: controller.year,
        title: '',
        userEmail: '',
      );
    }
  }

  loadList() async {
    list = box.values.toList() ?? [];
    filtered = box.values
        .where((var object) => object.month == widget.monthIndex)
        .toList();
  }
}
