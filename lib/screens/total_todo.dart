/*
import 'package:flutter/material.dart';

class TotalTodo extends StatelessWidget {
  const TotalTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text('abc'),
            Text('bbc'),
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TotalTodo extends StatelessWidget {
  const TotalTodo({super.key});

  @override
  Widget build(BuildContext context) {
    //final NoteController nc = Get.put(NoteController);
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  height: 78,
                  width: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'Task',
                      style: TextStyle(
                          color: Color.fromARGB(223, 26, 2, 129),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox.shrink();
            },
            itemCount: 2),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TotalTodo extends StatelessWidget {
  const TotalTodo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.1,
                  height: double.maxFinite,
                  child: const Text(
                    '22',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: const Text(
                        'Task Description',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ),
                /* Container(
                  alignment: Alignment.center,
                  width: size.width * 0.1,
                  height: double.maxFinite,
                  child: Icon(Icons.circle_outlined),
                )
                */
              ],
            ),
          ),
        ),
        /*
        child: Center(
          child: Text('No Task Found'),
        ),
        */
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:todo/model/task.dart';

class TotalTodo extends StatefulWidget {
  const TotalTodo({super.key});

  @override
  State<TotalTodo> createState() => _TotalTodoState();
}

class _TotalTodoState extends State<TotalTodo> {
  final box = Hive.box('myBox');
  List<dynamic> hiveData = [];

  @override
  void initState() {
    hiveData.addAll(box.get('data'));
    print(hiveData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Todo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: hiveData.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Background color
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: ListTile(
                      title: Text(hiveData[index]['title']),
                      subtitle: Text(hiveData[index]['description']),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
