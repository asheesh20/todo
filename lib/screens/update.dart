import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:todo/model/task.dart';
import 'package:todo/screens/new_todo.dart';
import 'package:todo/utils/colors.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final box = Hive.box('myBox');
  List<dynamic> hiveData = [];

  @override
  void initState() {
    hiveData.addAll(box.get('data'));
    print(hiveData);
    int count = hiveData.length;
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Background color
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _extractDate(hiveData[index]['date']),
                            style: const TextStyle(fontSize: 19),
                          ),
                          Text(
                            _extractMonth(hiveData[index]['date']),
                            style: TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                      title: Text(
                        hiveData[index]['title'],
                        style: TextStyle(fontSize: 23, color: backgroundColor),
                      ),
                      subtitle: Text(hiveData[index]['description']),
                      trailing: GestureDetector(
                          onTap: () {
                            // Get.to(UpdateTodo);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => NewTodo())));
                          },
                          child: const Icon(Icons.pin_end_rounded)),

                      /*
                      trailing: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hiveData[index]['isComplete'] ? green : red,
                        ),
                      ),
                      */
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _extractDate(String dateString) {
  List<String> dateParts = dateString.split("/");
  String day = dateParts[0];
  String month = dateParts[1];
  String year = dateParts[2];

  return '$day'; // Assuming date format is DD/MM/YY
}

String _extractMonth(String dateString) {
  List<String> dateParts = dateString.split("/");
  String day = dateParts[0];
  String month = dateParts[1];
  String year = dateParts[2];

  return '$month'; // Assuming date format is DD/MM/YY
}
