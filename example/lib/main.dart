import 'package:dependency_injection_flutter/dependency_injection_flutter.dart';
import 'package:example/src/ui/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

import 'src/ui/home/home_page.dart';

void main() {
  var homeController = HomeController();
  homeController.increment();

  Injector.instance.inject<HomeController>(() => homeController);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
