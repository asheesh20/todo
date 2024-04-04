/*
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/model/task.dart';
import 'package:todo/utils/colors.dart';

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

*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:todo/utils/colors.dart';

class TotalTodo extends StatefulWidget {
  const TotalTodo({super.key});

  @override
  State<TotalTodo> createState() => _TotalTodoState();
}

class _TotalTodoState extends State<TotalTodo> {
  // Firestore reference
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Todo'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: todosCollection.snapshots(), // Stream to listen for changes
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            // Extract data from Firestore snapshot
            final List<DocumentSnapshot> todos = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index].data() as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _extractDate(todo['date']),
                                style: const TextStyle(fontSize: 19),
                              ),
                              Text(
                                _extractMonth(todo['date']),
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                          title: Text(
                            todo['title'],
                            style: const TextStyle(
                                fontSize: 23, color: backgroundColor),
                          ),
                          subtitle: Text(todo['description']),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _extractDate(String dateString) {
    List<String> dateParts = dateString.split("/");
    String day = dateParts[0];
    String month = dateParts[1];
    String year = dateParts[2];

    return '$day';
  }

  String _extractMonth(String dateString) {
    List<String> dateParts = dateString.split("/");
    String day = dateParts[0];
    String month = dateParts[1];
    String year = dateParts[2];

    return '$month';
  }
}
