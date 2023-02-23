import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/controller/controller.dart';

import '../../../services/firebase_service.dart';
import '../../page/login_register/login_screen.dart';

class LogoutDialog extends StatelessWidget {
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Text("Çıkmak istediğinize emin misiniz?"),
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
            await MyFirebaseService().signOut();
            Get.offAll(LoginScreen());
          },
        ),
      ],
    );
  }
}
