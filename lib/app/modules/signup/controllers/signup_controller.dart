import 'dart:developer';

import 'package:flutter_nhost_todo/consts.dart';
import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

class SignupController extends GetxController {
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

  final signUpError = "".obs;

  Future<bool> signupWithEmailPassword({required String email, required String password}) async {
    try {
      await nhostClient.auth.signUp(email: email, password: password);
      return true;
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signUpError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
