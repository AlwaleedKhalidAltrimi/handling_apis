import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/user_binding.dart';
import 'views/users_view.dart';

void main() {
  runApp(const HandlingApis());
}

class HandlingApis extends StatelessWidget {
  const HandlingApis({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: UserBinding(),
      home: UsersView(),
    );
  }
}
