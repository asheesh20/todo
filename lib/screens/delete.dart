import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/model/task.dart';
import 'package:todo/utils/alert_box.dart';
import 'package:todo/utils/colors.dart';

class DeleteTodo extends StatefulWidget {
  const DeleteTodo({super.key});

  @override
  State<DeleteTodo> createState() => _DeleteTodoState();
}

class _DeleteTodoState extends State<DeleteTodo> {
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
        title: const Text('Delete Todo'),
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
                            setState(() {
                              print(hiveData.length);
                              print(hiveData);
                              print(hiveData[index]);
                              hiveData.removeAt(index);
                              print(hiveData.length);

                              print("after removing == $hiveData");
                              box.put('data', hiveData);
                            });
                            /*showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogBox();
                                });
                                */
                          },
                          child: Icon(Icons.delete)),
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
