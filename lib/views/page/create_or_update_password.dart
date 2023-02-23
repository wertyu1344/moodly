import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kelime_app/main.dart';
import 'package:kelime_app/views/widget/my_snackbar.dart';
import 'package:pinput/pinput.dart';

class CreateOrUpdatePassword extends StatefulWidget {
  CreateOrUpdatePassword({Key? key}) : super(key: key);

  @override
  State<CreateOrUpdatePassword> createState() => _CreateOrUpdatePasswordState();
}

class _CreateOrUpdatePasswordState extends State<CreateOrUpdatePassword> {
  TextEditingController textController = TextEditingController();
  String password = "";
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final box = GetStorage();
  int stepNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stepNumber == 0 ? "Enter passcode" : "Re-Enter passcode",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Pinput(
                  defaultPinTheme: defaultPinTheme,
                  mainAxisAlignment: MainAxisAlignment.center,
                  autofocus: true,
                  controller: textController,
                  closeKeyboardWhenCompleted: true,
                  onCompleted: (var a) async {
                    if (stepNumber == 0) {
                      stepNumber++;
                      password = textController.text;
                      textController.clear();

                      setState(() {});
                    } else if (stepNumber == 1) {
                      if (textController.text == password) {
                        await box.write("password", textController.text);
                        Get.offAll(MyHomePage());
                        showMySnackbar(
                            title: "Başarılı",
                            subTitle: "Şifre başarıyla güncellendi");
                      } else {
                        showMySnackbar(
                            title: "Hata", subTitle: "Şifreler aynı olmalı");
                        stepNumber = 0;
                        password = "";
                        textController.clear();
                        setState(() {});
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
