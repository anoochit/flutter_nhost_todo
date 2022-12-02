import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/app/routes/app_pages.dart';

import 'package:get/get.dart';

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
            ),

            // password
            TextFormField(
              controller: _textPassword,
              decoration: const InputDecoration(
                hintText: 'password',
                label: Text('Password'),
              ),
              obscureText: true,
            ),

            // button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 48),
              ),
              onPressed: () {
                // sign up a new account
                if (_formKey.currentState!.validate()) {}
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
