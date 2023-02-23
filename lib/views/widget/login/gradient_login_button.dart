import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/const/keys.dart';
import 'package:kelime_app/controller/controller.dart';
import 'package:kelime_app/views/widget/my_snackbar.dart';

import '../../../main.dart';
import '../../../services/firebase_service.dart';
import '../../../style/pallete.dart';

class GradientLoginButton extends StatefulWidget {
  GradientLoginButton({Key? key}) : super(key: key);

  @override
  State<GradientLoginButton> createState() => _GradientLoginButtonState();
}

class _GradientLoginButtonState extends State<GradientLoginButton> {
  Controller controller = Get.put(Controller());

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: () async {
          await login();
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : const Text(
                'Giriş yap',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
      ),
    );
  }

  login() async {
    print("logine bastı");
    if (MyKeys.keyLogin.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      bool isSucces = await MyFirebaseService().signInWithEmailAndPassword(
          controller.mailControllerLogin.text,
          controller.passwordControllerLogin.text);

      if (isSucces) {
        Get.offAll(MyHomePage());
      } else {
        setState(() {
          isLoading = false;
        });
        showMySnackbar(
            title: "Hata", subTitle: "Giriş yaparken bir sorun oluştu");
      }
    }
  }
}
