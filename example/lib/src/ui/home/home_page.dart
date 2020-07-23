import 'package:dependency_injection_flutter/dependency_injection_flutter.dart';
import 'package:example/src/ui/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with InjectionMixin<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(controller.value.toString() //output should be 1
            ),
      ),
    );
  }
}
