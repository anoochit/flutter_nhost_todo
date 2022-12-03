import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/app/routes/app_pages.dart';
import 'package:flutter_nhost_todo/consts.dart';

import 'package:get/get.dart';
import 'package:nhost_flutter_auth/nhost_flutter_auth.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _textEmail = TextEditingController();
  final _textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // email
            TextFormField(
              controller: _textEmail,
              decoration: const InputDecoration(
                hintText: 'email',
                label: Text('E-Mail'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter e-mail";
                }

                return null;
              },
            ),

            // password
            TextFormField(
              controller: _textPassword,
              decoration: const InputDecoration(
                hintText: 'password',
                label: Text('Password'),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter password";
                }

                return null;
              },
            ),

            // button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 48),
              ),
              onPressed: () async {
                // sign up a new account
                if (_formKey.currentState!.validate()) {
                  final result = await controller.signupWithEmailPassword(
                    email: _textEmail.text,
                    password: _textPassword.text,
                  );

                  if (result == true) {
                    // goto sign in page
                    Get.snackbar("Info", "Open your email and activate your account!");
                  } else {
                    // show error
                    Get.snackbar("Error", controller.signUpError.value);
                  }
                }
              },
              child: const Text("Sign Up"),
            ),

            // sign in
            const SizedBox(height: 16.0),
            const Text("Already have an account ?"),
            TextButton(
              onPressed: () => Get.offAllNamed(Routes.SIGNIN),
              child: const Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
