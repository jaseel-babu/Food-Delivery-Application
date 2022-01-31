import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speechtotext/views/details.dart';
import 'package:speechtotext/views/loginpage.dart';
import 'controller/controller.dart';
import 'views/homepage.dart';
import 'package:lint/lint.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    
    const GetMaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());

    return GetBuilder<Controller>(builder: (Controller) {
      return controller.value == true ? controller.userishere==true? FirstPage():LoginPage() : HomePage();
    },);
  }
}
