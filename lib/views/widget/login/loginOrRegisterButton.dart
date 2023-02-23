import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/controller/controller.dart';
import 'package:kelime_app/views/page/login_register/login_screen.dart';
import 'package:kelime_app/views/page/login_register/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  bool isLogin;
  LoginOrRegister({required this.isLogin, Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLoading = false;

  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.isLogin ? "Hesabın yok mu?" : "Hesabın var mı?"),
        TextButton(
          onPressed: () async {
            widget.isLogin
                ? Get.offAll(() => RegisterScreen())
                : Get.offAll(() => LoginScreen());
          },
          child: Text(
            !widget.isLogin ? "Giriş Yap" : "Kayıt ol",
            style: const TextStyle(color: Colors.blueAccent),
          ),
        )
      ],
    );
  }
}
