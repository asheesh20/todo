import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:todo/screens/delete.dart';
import 'package:todo/screens/new_todo.dart';
import 'package:todo/screens/total_todo.dart';
import 'package:todo/screens/update.dart';
import 'package:todo/utils/colors.dart';
import 'package:todo/widgets/category_grid.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = Hive.box('myBox');

  List<dynamic> hiveData = [];

  @override
  void initState() {
    setState(() {
      hiveData.addAll(box.get('data'));
      print(hiveData);
    });
    // hiveData.addAll(box.get('data'));
    //print(hiveData);
    // int count = hiveData.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                'Todo\'s',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${hiveData.length}',
                style: const TextStyle(
                    fontSize: 36, color: yellow, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BoxMethod(),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const UpdateTodo());
                    },
                    child: const CategoryGrid(
                      title: 'Update Todo',
                      icon: Icon(
                        Icons.pin_end_rounded,
                        color: yellow,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Get.to(const TotalTodo(taskTitle: ));
                      Get.to(const TotalTodo());
                    },
                    child: const CategoryGrid(
                      title: 'Total Todo',
                      icon: Icon(
                        Icons.checklist_sharp,
                        color: yellow,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const DeleteTodo());
                    },
                    child: const CategoryGrid(
                      title: 'Delete Todo',
                      icon: Icon(
                        Icons.delete_outline,
                        color: yellow,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxMethod extends StatelessWidget {
  const BoxMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(NewTodo());
      },
      child: const CategoryGrid(
        title: 'New Todo',
        icon: Icon(
          Icons.add,
          color: yellow,
        ),
      ),
    );
  }
}
