import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_listapp/routes/app_routes.dart';
import 'modules/auth/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final user = _auth.currentUser;

    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      title: "Todo App",

      // ⭐ AUTO LOGIN CHECK
      initialRoute: user == null ? "/login" : "/tasks",

      getPages: AppPages.pages,
    );
  }
}