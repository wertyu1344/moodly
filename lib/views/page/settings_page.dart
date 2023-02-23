import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_app/views/page/password_page.dart';

import '../widget/login/logout_dialog.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
          mail(),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => PasswordPage());
                },
                child: Container(
                  height: 51,
                  color: const Color.fromRGBO(36, 40, 54, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PIN",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                              size: 14,
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Remove ads",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Remove all ads permanently",
                  style: TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 1), fontSize: 13),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(75, 78, 106, 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/remove_ad.png",
                          width: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Remove Ads in App",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    Get.dialog(LogoutDialog());
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Padding mail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text(
            "E-mail address",
            style: TextStyle(
                color: Color.fromRGBO(217, 217, 217, 1),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white,
                )),
            child: Text(
              _auth.currentUser?.email ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
