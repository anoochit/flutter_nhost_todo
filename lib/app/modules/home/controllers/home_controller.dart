import 'package:flutter_nhost_todo/consts.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addTask({required String task}) {
    final uuid = Uuid();
    final uuidValue = uuid.v4();
  }
}
