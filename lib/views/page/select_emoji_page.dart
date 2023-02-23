import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/models/emoji.dart';
import 'package:kelime_app/views/page/record_page.dart';
import 'package:kelime_app/views/page/record_play_page.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../models/day_model.dart';

class SelectEmojiPage extends StatelessWidget {
  DayModel dayModel;
  SelectEmojiPage({required this.dayModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
          waveType: WaveType.liquidReveal,
          enableLoop: false,
          initialPage: 0,
          pages: createPageList()),
    );
  }

  List<Widget> createPageList() {
    return emojiList.map((Emoji emoji) {
      return Container(
        color: emoji.color,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Gününü hangi emoji ile tanımlarsın?",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: emoji.number == 0
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Image.asset(
                          emoji.url,
                          width: 120,
                          height: 120,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        emoji.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: emoji.number + 1 == emojiList.length
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  dayModel.emoji = emoji;
                  Get.to(() => AudioRecorder(
                        onStop: (String path) {
                          dayModel.voicePath = path;

                          Get.to(RecordPlayPage(
                              isRecordFinished: false, dayModel: dayModel));
                        },
                        dayModel: dayModel,
                      ));
                },
                child: const Text(
                  "Seç",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

List<Emoji> emojiList = [
  Emoji(
      number: 0,
      name: "Aşık",
      url: "images/emojiler/asik.png",
      color: const Color.fromRGBO(240, 138, 184, 1)),
  Emoji(
      number: 1,
      name: "Hasta",
      url: "images/emojiler/hasta.png",
      color: const Color.fromRGBO(249, 178, 51, 1)),
  Emoji(
      number: 2,
      name: "Kızgın",
      url: "images/emojiler/kizgin.png",
      color: const Color.fromRGBO(227, 6, 19, 1)),
  Emoji(
      number: 3,
      name: "Korkmuş",
      url: "images/emojiler/korkmus.png",
      color: const Color.fromRGBO(149, 198, 236, 1)),
  Emoji(
      number: 4,
      name: "Mutlu",
      url: "images/emojiler/mutlu.png",
      color: const Color.fromRGBO(255, 237, 0, 1)),
  Emoji(
      number: 5,
      name: "Şaşkın",
      url: "images/emojiler/saskin.png",
      color: const Color.fromRGBO(243, 146, 0, 1)),
  Emoji(
      number: 6,
      name: "Tiksinç",
      url: "images/emojiler/tiksinen.png",
      color: const Color.fromRGBO(47, 172, 102, 1)),
  Emoji(
      number: 7,
      name: "Uykulu",
      url: "images/emojiler/uykulu.png",
      color: const Color.fromRGBO(93, 84, 159, 1)),
  Emoji(
      number: 8,
      name: "Üzgün",
      url: "images/emojiler/uzgun.png",
      color: const Color.fromRGBO(51, 183, 234, 1)),
  Emoji(
      number: 9,
      name: "Yorgun",
      url: "images/emojiler/yorgun.png",
      color: const Color.fromRGBO(245, 178, 209, 1)),
];
