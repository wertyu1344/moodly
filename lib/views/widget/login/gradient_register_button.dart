import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/const/keys.dart';
import 'package:kelime_app/views/widget/my_snackbar.dart';

import '../../../controller/controller.dart';
import '../../../main.dart';
import '../../../services/firebase_service.dart';
import '../../../style/pallete.dart';

class GradientRegisterButton extends StatefulWidget {
  GradientRegisterButton({Key? key}) : super(key: key);

  @override
  State<GradientRegisterButton> createState() => _GradientRegisterButtonState();
}

class _GradientRegisterButtonState extends State<GradientRegisterButton> {
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
          await register();
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
                'Kayıt ol',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
      ),
    );
  }

  register() async {
    if (MyKeys.keyRegister.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      bool isSucces = await MyFirebaseService().createUserWithEmailAndPassword(
          controller.mailControllerRegister.text,
          controller.passwordControllerRegister.text);

      if (isSucces) {
        Get.offAll(MyHomePage());
      } else {
        setState(() {
          isLoading = false;
        });

        showMySnackbar(
            title: "Hata", subTitle: "Kayıt olurken bir sorun oluştu");
      }
    }
  }
}
