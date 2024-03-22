import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:todo/screens/new_todo.dart';
import 'package:todo/screens/total_todo.dart';
import 'package:todo/widgets/category_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              const Text(
                '2',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxMethod(),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const NewTodo());
                    },
                    child: const CategoryGrid(
                      title: 'Update Todo',
                      icon: Icon(
                        Icons.pin_end_rounded,
                        color: Colors.yellow,
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
                      Get.to(const TotalTodo());
                    },
                    child: const CategoryGrid(
                      title: 'Total Todo',
                      icon: Icon(
                        Icons.checklist_sharp,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const NewTodo());
                    },
                    child: const CategoryGrid(
                      title: 'Delete Todo',
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.yellow,
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
        Get.to(const NewTodo());
      },
      child: const CategoryGrid(
        title: 'New Todo',
        icon: Icon(
          Icons.add,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
