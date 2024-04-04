import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewTodoController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  var selectedDate = DateTime.now().obs;
  var isComplete = false.obs;

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void setComplete(bool value) {
    isComplete.value = value;
  }

/*
  Future<String> saveTodo() async {
    String docId = '';
    return docId;
  }
*/
  Future<String> saveTodo() async {
    try {
      final DocumentReference docRef =
          await FirebaseFirestore.instance.collection('todos').add({
        'title': title.value,
        'description': description.value,
        'date': DateFormat('dd/MM/yyyy').format(selectedDate.value),
        'isComplete': isComplete.value,
      });
      final String docId = docRef.id;
      print('Todo saved with docId: $docId');
      return docId;
    } catch (e) {
      print('Error saving todo: $e');
      return '';
    }
  }
}
