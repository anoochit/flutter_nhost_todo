import 'dart:developer';

import 'package:flutter_nhost_todo/consts.dart';
import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

class SigninController extends GetxController {
  RxString signInError = "".obs;

  Future<bool> signInWithEmailPassword({required String email, required String password}) async {
    try {
      final authResponse = await client.auth.signInEmailPassword(email: email, password: password);
      return (authResponse.user != null) ? true : false;
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signInError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
