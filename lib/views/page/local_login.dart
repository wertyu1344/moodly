import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kelime_app/main.dart';
import 'package:pinput/pinput.dart';

class LocalLoginPage extends StatefulWidget {
  LocalLoginPage({Key? key}) : super(key: key);

  @override
  State<LocalLoginPage> createState() => _LocalLoginPageState();
}

class _LocalLoginPageState extends State<LocalLoginPage> {
  final pinputFocusNode = FocusNode();
  TextEditingController textController = TextEditingController();
  String password = "";
  final defaultPinTheme = PinTheme(
    width: 48,
    height: 48,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final box = GetStorage();
  bool isWrong = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isWrong ? "Hatalı şifre" : "Şifreyi girin",
                style:
                    TextStyle(color: isWrong ? Colors.redAccent : Colors.white),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Pinput(
                      focusNode: pinputFocusNode,
                      defaultPinTheme: defaultPinTheme,
                      mainAxisAlignment: MainAxisAlignment.center,
                      autofocus: true,
                      controller: textController,
                      closeKeyboardWhenCompleted: true,
                      onCompleted: (var a) async {
                        if (box.read("password") == textController.text) {
                          isWrong = false;
                          Get.offAll(MyHomePage());
                        } else {
                          textController.clear();
                          isWrong = true;
                          setState(() {});
                          pinputFocusNode.requestFocus();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
          InkWell(
            child: Image.asset(
              "images/fingerprint.png",
              width: 96,
            ),
          ),
        ],
      ),
    );
  }
}
