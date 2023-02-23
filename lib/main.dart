import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:kelime_app/controller/controller.dart';
import 'package:kelime_app/models/color_adapter.dart';
import 'package:kelime_app/models/day_model.dart';
import 'package:kelime_app/models/emoji.dart';
import 'package:kelime_app/services/firebase_service.dart';
import 'package:kelime_app/views/page/local_login.dart';
import 'package:kelime_app/views/page/login_register/login_screen.dart';
import 'package:kelime_app/views/page/settings_page.dart';
import 'package:kelime_app/views/widget/month_widgets.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await GetStorage.init();

  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(documentDirectory.path)
    ..registerAdapter(DayModelAdapter());
  Hive
    ..init(documentDirectory.path)
    ..registerAdapter(EmojiAdapter());
  Hive
    ..init(documentDirectory.path)
    ..registerAdapter(ColorAdapter());
  await Hive.openBox<DayModel>("voice");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (box.read("isPasswordOpen") ?? false) {
              return LocalLoginPage();
            } else {
              return const MyHomePage();
            }
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController? pageController;
  List months = [];
  Controller controller = Get.put(Controller());
  @override
  void initState() {
    pageController = PageController(initialPage: DateTime.now().month - 1);
    months = [31, setSubat(), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              await MyFirebaseService().signOut();
              Get.offAll(LoginScreen());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () async {
              Get.to(SettingsPage());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: pageController,
          itemBuilder: (context, index) {
            return Month(
              monthName: controller.monthList[index],
              monthIndex: index + 1,
              monthDay: months[index],
            );
          },
          itemCount: 12,
        ),
      ),
    );
  }

  int setSubat() {
    if (DateTime.now().year % 4 == 0) {
      return 29;
    } else {
      return 28;
    }
  }
}
