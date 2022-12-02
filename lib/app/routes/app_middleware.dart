import 'package:flutter/material.dart';
import 'package:flutter_nhost_todo/app/routes/app_pages.dart';
import 'package:flutter_nhost_todo/consts.dart';
import 'package:get/get.dart';

class RouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return (client.auth.currentUser != null) ? null : const RouteSettings(name: Routes.SIGNIN);
  }
}
