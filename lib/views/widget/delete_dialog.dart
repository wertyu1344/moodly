import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kelime_app/controller/controller.dart';
import 'package:kelime_app/main.dart';

import '../../models/day_model.dart';

class MyDialog extends StatelessWidget {
  DayModel dayModel;
  MyDialog({required this.dayModel});

  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Text("Silmek istediğinize emin misiniz?"),
      content: Container(
        child: Text("Bu işlem geri alınamaz."),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)),
          child: Text(
            "Hayır",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: const Text(
            "Evet",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            Box<DayModel> box = Hive.box("voice");
            await box
                .delete("${controller.year}:${dayModel.month}:${dayModel.day}");
            Get.offAll(MyHomePage());
          },
        ),
      ],
    );
  }
}
