import 'package:flutter/material.dart';
import 'Routes/Routes.dart';
import 'Views/AddEmployee.dart';
import 'Views/Login.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
       initialRoute:Login.route,
      routes: routes,
    );
  }
}

