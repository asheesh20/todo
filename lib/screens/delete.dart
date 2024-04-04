import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/controller/todo_controller.dart';
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
                              // print(hiveData);
                              //print(hiveData[index]);
                              hiveData.removeAt(index);
                              // print(hiveData.length);

                              //print("after removing == $hiveData");
                              box.put('data', hiveData);
                            });
                            /*showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogBox();
                                });
                                */
                          },
                          child: const Icon(Icons.delete)),
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




/*

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/utils/colors.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});
  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final box = Hive.box('myBox');
  List<dynamic> hiveData = [];

  @override
  void initState() {
    hiveData.addAll(box.get('data'));
    print(hiveData);
    super.initState();
  }
  //Box box = Hive.box('myBox');

  String title = "";
  String description = "";
  DateTime selectedDate = DateTime.now();
  bool isComplete = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // print(box.toMap().toString());
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 280),
                  child: Text(
                    'Title',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: grey100),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey100),
                      ),
                      fillColor: grey100,
                      hintText: 'Enter title here',
                      hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      filled: true,
                      //labelText: 'Title',
                    ),
                    enableSuggestions: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      title = newValue!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 234),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: grey100),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey100),
                      ),
                      fillColor: grey200,
                      hintText: 'Enter Description here',
                      hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      filled: true,
                      //labelText: 'Title',
                    ),
                    enableSuggestions: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      description = newValue!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 14,
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(backgroundColor),
                      ),
                      onPressed: () => _selectDate(context),
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                      label: Text(
                        // '${selectedDate.toIso8601String().split('T')[0]}',
                        formattedDate,
                        style: const TextStyle(color: white),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      'Select Date',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: isComplete,
                          onChanged: (value) {
                            setState(() {
                              isComplete = value as bool;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Incomplete'),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isComplete,
                          onChanged: (value) {
                            setState(() {
                              isComplete = value as bool;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Complete'),
                      ],
                    ),
                    //const Text('Incomplete'),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                AddButton(
                  formKey: _formKey,
                  title: title,
                  description: description,
                  selectedDate: selectedDate,
                  isComplete: isComplete,
                  descriptionController: _descriptionController,
                  titleController: _titleController,
                  formattedDate: formattedDate,
                  onTap: () {
                    Map<String, dynamic> dataMap = {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'date': formattedDate,
                      'isComplete': isComplete,
                    };
                    final box = Hive.box('myBox');
                    hiveData.add(dataMap);

                    box.put('data', hiveData);
                    print(box.toMap().toString());
                    Navigator.of(context).pop();

                    /// for clearing the box

                    //final box = Hive.box('myBox');
                    //box.clear();
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.title,
    required this.description,
    required this.selectedDate,
    required this.isComplete,
    required this.descriptionController,
    required this.titleController,
    required this.formattedDate,
    required this.onTap,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String title;
  final String description;
  final DateTime selectedDate;
  final bool isComplete;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String formattedDate;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor,
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // Add logic to save todo data
          //print('Todo: $title, $description, $selectedDate, $isComplete');
        }
      },
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          'Add',
          style: TextStyle(color: white, fontSize: 20),
        ),
      ),
    );
  }
}





*/