import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  SigninView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _textEmail = TextEditingController();
  final _textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO : mock user data
    _textEmail.text = "demo@example.com";
    _textPassword.text = "Hello123";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
                  return "enter e-mail address";
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
                  return "enter password";
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
                await signIn();
              },
              child: const Text("Sign In"),
            ),

            // sign in
            const SizedBox(height: 16.0),
            const Text("Don't have an account ?"),
            TextButton(
              onPressed: () => Get.offAllNamed(Routes.SIGNUP),
              child: const Text("Sign up"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      final result = await controller.signInWithEmailPassword(
        email: _textEmail.text,
        password: _textPassword.text,
      );
      if (result == false) {
        Get.snackbar('Error', controller.signInError.value);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    }
  }
}
