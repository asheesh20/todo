import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// initialize hive
  await Hive.initFlutter();

  /// opened the box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      home: HomeScreen(),
    );
  }
}
