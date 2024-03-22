import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/new_todo.dart';
import 'package:todo/utils/colors.dart';
import 'package:todo/widgets/category_grid.dart';

class BoxMethod extends StatelessWidget {
  const BoxMethod({super.key, required this.title, required this.onSelect});

  final void Function() onSelect;
  final String title;

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
          color: yellow,
        ),
      ),
    );
  }
}
