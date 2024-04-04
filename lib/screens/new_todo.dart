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

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/new_todo.controller.dart';
import 'package:todo/utils/colors.dart';

class NewTodo extends StatelessWidget {
  final NewTodoController controller = Get.put(NewTodoController());

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(
                () => TextFormField(
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
                  ),
                  enableSuggestions: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.title.value = value,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => TextFormField(
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
                  onChanged: (value) => controller.description.value = value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      controller.selectDate(pickedDate);
                    }
                  },
                  child: Text(
                      'Select Date: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CheckboxListTile(
                  title: const Text('Complete'),
                  value: controller.isComplete.value,
                  onChanged: (value) => controller.setComplete(value ?? false),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.saveTodo();
                  Get.back();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/new_todo.controller.dart';
import 'package:todo/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTodo extends StatelessWidget {
  final NewTodoController controller = Get.put(NewTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GetBuilder<NewTodoController>(
                builder: (_) => TextFormField(
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
                    //labelText: 'text'
                  ),
                  enableSuggestions: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.title.value = value,
                ),
              ),
              const SizedBox(height: 20),
              GetBuilder<NewTodoController>(
                builder: (_) => TextFormField(
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
                  ),
                  enableSuggestions: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onChanged: (value) => controller.description.value = value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<NewTodoController>(
                builder: (_) => TextButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      controller.selectDate(pickedDate);
                    }
                  },
                  child: Text(
                    'Select Date: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<NewTodoController>(
                builder: (_) => CheckboxListTile(
                  title: const Text('Complete'),
                  value: controller.isComplete.value,
                  onChanged: (value) => controller.setComplete(value ?? false),
                ),
              ),
              const SizedBox(height: 20),
              /*
              ElevatedButton(
                onPressed: () async {
                  // Get the docId
                  final String docId = await controller.saveTodo();

                  // Store data to Firestore
                  final Map<String, dynamic> data = {
                    'title': controller.title.value,
                    'description': controller.description.value,
                    'date': DateFormat('dd/MM/yyyy')
                        .format(controller.selectedDate.value),
                    'isComplete': controller.isComplete.value,
                    'docId': docId
                  };

                  try {
                    await FirebaseFirestore.instance
                        .collection('todos')
                        .add(data);
                    print('Data saved to Firestore');
                  } catch (e) {
                    print('Error saving data: $e');
                  }

                  Get.back();
                },
                child: const Text('Add'),
              ),
              */
              ElevatedButton(
                onPressed: () async {
                  final String docId = await controller.saveTodo();

                  final Map<String, dynamic> data = {
                    'title': controller.title.value,
                    'description': controller.description.value,
                    'date': DateFormat('dd/MM/yyyy')
                        .format(controller.selectedDate.value),
                    'isComplete': controller.isComplete.value,
                    'docId': docId
                  };

                  try {
                    await FirebaseFirestore.instance
                        .collection('todos')
                        .doc(docId) // Use the obtained docId here
                        .set(data);
                    print('Data saved to Firestore');
                  } catch (e) {
                    print('Error saving data: $e');
                  }

                  Get.back();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

















/*
void saveDataToFirestore() async {
    final Map<String, dynamic> data = {
      'title': controller.title.value,
      'description': controller.description.value,
      'date': DateFormat('dd/MM/yyyy').format(controller.selectedDate.value),
      'isComplete': controller.isComplete.value,
    };

    try {
      await firestore.collection('todos').add(data);
      print('Data saved to Firestore');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}

*/
