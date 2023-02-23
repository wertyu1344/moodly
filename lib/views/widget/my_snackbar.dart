import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMySnackbar({required String title, required String subTitle}) {
  return Get.snackbar(title, subTitle,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      colorText: Colors.white,
      backgroundColor: Colors.black45);
}
