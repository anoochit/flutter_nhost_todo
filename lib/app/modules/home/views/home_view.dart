import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/app/data/graphql/graphql_query.dart';
import 'package:flutter_nhost_todo/app/data/model/todo_model.dart';
import 'package:flutter_nhost_todo/app/routes/app_pages.dart';
import 'package:flutter_nhost_todo/consts.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final _textTask = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log('uid = ${nhostClient.auth.currentUser!.id}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     nhostClient.auth.signOut().then(
          //           (value) => Get.offAllNamed(Routes.SIGNIN),
          //         );
          //   },
          //   icon: const Icon(Icons.exit_to_app),
          // ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),

      // show todo, use graphql subscription
      body: Subscription(
        options: SubscriptionOptions(
          document: getTodosSubscription,
        ),
        builder: (result) {
          // has error
          if (result.hasException) {
            log(result.exception.toString());
            return Text(result.exception.toString());
          }

          // has loading
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // show list
          final todos = (result.data!['todos'] as List).map((json) => Todo.fromMap(json)).toList();

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Mutation(
                options: MutationOptions(document: updateTodoStatus),
                builder: (runMutation, result) {
                  return CheckboxListTile(
                    title: Text(
                      todos[index].name,
                      style:
                          (todos[index].is_completed) ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
                    ),
                    value: todos[index].is_completed,
                    onChanged: (value) async {
                      // update task status
                      log('id = ${todos[index].id}');
                      runMutation({
                        "todo_id": todos[index].id,
                        "is_completed": value,
                      });
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add todo
          Get.dialog(
            Mutation(
              options: MutationOptions(document: addTodo),
              builder: (runMutation, result) {
                return AlertDialog(
                  title: const Text("Add task"),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _textTask,
                      decoration: const InputDecoration(hintText: 'Task title'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter task";
                        }
                        return null;
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // add task
                        if (_formKey.currentState!.validate()) {
                          runMutation({
                            'todo': {
                              'name': _textTask.text,
                              'user_id': nhostClient.auth.currentUser!.id,
                            },
                          });
                          _textTask.clear();
                          Get.back();
                        }
                      },
                      child: const Text("Add"),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
