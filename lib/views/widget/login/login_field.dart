import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/controller/controller.dart';

import '../../../style/pallete.dart';

class LoginField extends StatelessWidget {
  TextEditingController textEditingController;
  final String hintText;
  bool isPassword;
  LoginField({
    this.isPassword = false,
    required this.textEditingController,
    Key? key,
    required this.hintText,
  }) : super(key: key);

  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "Alan boş bırakılamaz";
          }

          if (textEditingController == controller.passwordControllerRegister) {
            if (v != controller.passwordAgainControllerRegister.text) {
              return 'Şifre uyuşmuyor';
            }
          }
          if (textEditingController ==
              controller.passwordAgainControllerRegister) {
            if (v != controller.passwordControllerRegister.text) {
              return 'Şifre uyuşmuyor';
            }
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPassword ? true : false,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.gradient2,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
