import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/consts.dart';

import 'package:get/get.dart';
import 'package:nhost_flutter_graphql/nhost_flutter_graphql.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  nhostClient = NhostClient(backendUrl: backendUrl);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NhostGraphQLProvider(
      nhostClient: nhostClient,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
