import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kelime_app/views/page/create_or_update_password.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PIN"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
      ),
      backgroundColor: const Color.fromRGBO(28, 31, 42, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              InkWell(
                onTap: () {
                  Get.to(CreateOrUpdatePassword());
                },
                child: Container(
                  height: 51,
                  color: Color.fromRGBO(36, 40, 54, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3),
              Container(
                height: 51,
                color: Color.fromRGBO(36, 40, 54, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Enable password",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(),
                      Switch(
                          activeColor: Colors.greenAccent,
                          value: box.read("isPasswordOpen") ?? false,
                          onChanged: (value) async {
                            await box.write("isPasswordOpen", value);
                            setState(() {});
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
