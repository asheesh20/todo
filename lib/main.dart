import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/screens/home.dart';

void main() async {
  /// initialize hive
  await Hive.initFlutter();

  /// open the box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      home: HomeScreen(),
    );
  }
}
