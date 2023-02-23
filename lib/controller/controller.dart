import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  List monthList = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];
  String year = DateTime.now().year.toString();

  //Login and Register
  TextEditingController mailControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController passwordAgainControllerRegister =
      TextEditingController();

  TextEditingController mailControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
}
