import 'package:flutter/material.dart';
import 'package:flutter_app_1/Views/AddEmployee.dart';
import 'package:flutter_app_1/Views/Dashboard.dart';
import 'package:flutter_app_1/Views/EditEmployee.dart';
import 'package:flutter_app_1/Views/Login.dart';
import 'package:flutter_app_1/Views/Register.dart';
Map<String,WidgetBuilder> routes={
  Login.route : (context) =>  LoginApp(),
  Register.route : (context) => RegisterApp(),
  Dashboard.route : (context) => DashboardApp(),
  AddEmployee.route :  (context)=>AddEmployeeApp(),
  EditEmployee.route :(context)=>EditEmployeeApp(),
};