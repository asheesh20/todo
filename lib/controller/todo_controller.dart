import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';

class TodoScreenController extends GetxController {
  RxList<dynamic> hiveData = [].obs;

  RxInt count = 0.obs;
  final box = Hive.box('myBox');

  getData() {
    hiveData.value.addAll(box.get('data'));
  }
}
