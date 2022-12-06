import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/app/data/graphql/graphql_query.dart';
import 'package:flutter_nhost_todo/app/data/model/user_model.dart';
import 'package:flutter_nhost_todo/app/routes/app_pages.dart';
import 'package:flutter_nhost_todo/consts.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Subscription(
        options: SubscriptionOptions(document: getUserProfileSubscription),
        builder: (result) {
          // has error
          if (result.hasException) {
            log('${result.exception}');
            return Text("Error");
          }

          // has loading
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // show data
          final profile = (result.data!['users'] as List).map((e) => UserProfile.fromMap(e)).toList();
          log('avatar = ${profile.first.avatarUrl}');

          return ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(profile.first.avatarUrl),
                    ),
                    Text('${profile.first.displayName}')
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Signout"),
                onTap: () {
                  nhostClient.auth.signOut().then((value) => Get.offAllNamed(Routes.SIGNIN));
                },
              )
            ],
          );
        },
      ),
    );
  }
}
