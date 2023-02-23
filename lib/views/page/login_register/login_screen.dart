import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/const/keys.dart';

import '../../../controller/controller.dart';
import '../../../style/pallete.dart';
import '../../widget/login/gradient_login_button.dart';
import '../../widget/login/loginOrRegisterButton.dart';
import '../../widget/login/login_field.dart';
import '../../widget/login/social_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    controller.passwordControllerLogin.clear();
    controller.mailControllerLogin.clear();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: MyKeys.keyLogin,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset('images/signin_balls.png'),
                    const Text(
                      'Sign in.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const SocialButton(
                        iconPath: 'images/g_logo.svg',
                        label: 'Google ile devam et'),
                    const SizedBox(height: 20),
                    const SizedBox(height: 15),
                    const Text(
                      'or',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 15),
                    LoginField(
                        textEditingController: controller.mailControllerLogin,
                        hintText: 'Email'),
                    const SizedBox(height: 15),
                    LoginField(
                        isPassword: true,
                        textEditingController:
                            controller.passwordControllerLogin,
                        hintText: 'Password'),
                    const SizedBox(height: 20),
                    GradientLoginButton(),
                    LoginOrRegister(
                      isLogin: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
