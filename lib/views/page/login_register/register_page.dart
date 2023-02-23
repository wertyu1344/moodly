import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/controller/controller.dart';
import 'package:kelime_app/views/widget/login/gradient_register_button.dart';

import '../../../const/keys.dart';
import '../../../style/pallete.dart';
import '../../widget/login/loginOrRegisterButton.dart';
import '../../widget/login/login_field.dart';
import '../../widget/login/social_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Controller controller = Get.put(Controller());

  @override
  void initState() {
    controller.passwordControllerRegister.clear();
    controller.passwordAgainControllerRegister.clear();
    controller.mailControllerRegister.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: MyKeys.keyRegister,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Image.asset('images/signin_balls.png'),
                    const Text(
                      'Sign up.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const SocialButton(
                        iconPath: 'images/g_logo.svg',
                        label: 'Continue with Google'),
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
                        textEditingController:
                            controller.mailControllerRegister,
                        hintText: 'Email'),
                    const SizedBox(height: 15),
                    LoginField(
                        isPassword: true,
                        textEditingController:
                            controller.passwordControllerRegister,
                        hintText: 'Password'),
                    const SizedBox(height: 15),
                    LoginField(
                        isPassword: true,
                        textEditingController:
                            controller.passwordAgainControllerRegister,
                        hintText: 'Password again'),
                    const SizedBox(height: 20),
                    GradientRegisterButton(),
                    LoginOrRegister(
                      isLogin: false,
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
