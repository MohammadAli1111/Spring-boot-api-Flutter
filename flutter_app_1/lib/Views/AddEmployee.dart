import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/Models/Employee.dart';
import 'package:flutter_app_1/Models/Jwt.dart';
import 'package:flutter_app_1/Models/User.dart';
import 'package:flutter_app_1/Views/Dashboard.dart';
import 'package:flutter_app_1/Views/Register.dart';
import 'package:http/http.dart' as http;

class AddEmployeeApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return AddEmployee();
  }

}
class AddEmployee extends State<AddEmployeeApp> {
  static const route="/addEmployee";
  final _formKey = GlobalKey<FormState>();
  String message="";
  Employee employee=new Employee(0,"","","");

  /*
  1-If you are testing your spring boot backend with flutter Emulator device
  then url should be
  String url = http://10.0.2.2:8080/api/v1/login';

  2-If you are testing your backend with real android phone then,
  define inbound firewall rule (in windows defender firewall ) and allow the port 80 in firewall rule.
  get the ip address of your system,
   and change the url to
   String url = 'http://ip:8080/api/v1/login';
   */
  String url = "http://10.0.2.2:8080/api/v1/user/addEmployee";

  Future save() async {
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json',
          "Authorization":"Bearer ${Jwt.token}"},
        body: json.encode(employee.toJson()));

    if (res.body != null) {
      setState(() {
          message=res.body;
      });
      var Employees= await http.get("http://10.0.2.2:8080/api/v1/user/Employees",
          headers:{"Authorization":"Bearer ${Jwt.token}"});
      var jsonMap = json.decode(Employees.body);
      Navigator.pushNamed(context, Dashboard.route,arguments: jsonMap);

    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor:  Colors.blue,
          body: SingleChildScrollView(

            child: Form(
                key: _formKey,

                child:Container(
                  padding:EdgeInsets.all(5) ,
                  width: MediaQuery.of(context).size.width,
                  // height:MediaQuery.of(context).size.height,

                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Icon(Icons.person_add,color: Colors.white,size: 100,),
                      Text("Add Employee",
                        style: TextStyle(color: Colors.white,fontSize:25,
                            fontWeight:FontWeight.bold ),
                      ),
                      Text(message,
                        style: TextStyle(color: Colors.green.shade900,fontSize:20,
                            ),
                      ),


                      SizedBox(height: 20,),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "First Name :",
                          style: TextStyle(color: Colors.white,fontSize:18,
                              fontWeight:FontWeight.w900 ),
                        ),
                      ),

                      TextFormField(

                        cursorColor: Colors.white,
                        controller: TextEditingController(text: employee.firstname),
                        onChanged: (val) {
                          employee.firstname = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'First Name is Empty';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        decoration: InputDecoration(
                            errorStyle:
                            TextStyle(fontSize:16, color:Color.fromRGBO(
                                248, 75, 75, 1.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),



                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Last Name :",
                          style: TextStyle(color: Colors.white,fontSize:18,
                              fontWeight:FontWeight.w900 ),
                        ),
                      ),
                      TextFormField(

                        cursorColor: Colors.white,
                        controller: TextEditingController(text: employee.lastname),
                        onChanged: (val) {
                          employee.lastname = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Last Name is Empty';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        decoration: InputDecoration(
                            errorStyle:
                            TextStyle(fontSize:16, color:Color.fromRGBO(
                                248, 75, 75, 1.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),


                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Job :",
                          style: TextStyle(color: Colors.white,fontSize:18,
                              fontWeight:FontWeight.w900 ),
                        ),
                      ),
                      TextFormField(
                        controller:
                        TextEditingController(text: employee.job),
                        onChanged: (val) {
                          employee.job = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Job is Empty';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        decoration: InputDecoration(
                            errorStyle:
                            TextStyle(fontSize: 16, color: Color.fromRGBO(
                                248, 75, 75, 1.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),

                      //____________________go register____________

                      SizedBox(
                        height: 40,
                      ),
                      //__________________Login Button_____________
                      Container(
                        height: 50,
                        width: 50,
                        child: FlatButton(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                save();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.save_outlined,
                              color: Colors.blue,
                              size: 20,
                            )),
                      )


                    ],
                  ),
                )
            ),
          ),
        )
    );
  }

}