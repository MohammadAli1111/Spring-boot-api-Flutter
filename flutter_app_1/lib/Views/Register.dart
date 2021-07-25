import 'package:flutter/material.dart';
import 'package:flutter_app_1/Models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class RegisterApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return Register();
  }

}
class Register extends State<RegisterApp> {
  static const route="/register";
  final _formKey = GlobalKey<FormState>();
  User user=new User(0,"","","");

  String url = "http://10.0.2.2:8080/api/v1/auth/register";

  Future save() async {
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()));

    if (res.body == "Successfully") {
      Navigator.pop(context);
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
                      Icon(Icons.verified_user,color: Colors.white,size: 100,),
                      Text("Sign Up",

                        style: TextStyle(color: Colors.white,fontSize:25,
                            fontWeight:FontWeight.bold ),
                      ),

                      SizedBox(height: 20,),
                      //______________username________
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "User Name :",
                          style: TextStyle(color: Colors.white,fontSize:18,
                              fontWeight:FontWeight.w900 ),
                        ),
                      ),

                      TextFormField(
                        cursorColor: Colors.white,

                        controller: TextEditingController(text: user.name),
                        onChanged: (val) {
                          user.name = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'User Name is Empty';
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
                      //______________Email_________
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email :",
                          style: TextStyle(color: Colors.white,fontSize:18,
                              fontWeight:FontWeight.w900 ),
                        ),
                      ),

                      TextFormField(
                        cursorColor: Colors.white,

                        controller: TextEditingController(text: user.email),
                        onChanged: (val) {
                          user.email = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email is Empty';
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

                      //____________Password________________
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Password :",
                          style: TextStyle(color: Colors.white,fontSize:18,
                              fontWeight:FontWeight.w900 ),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller:
                        TextEditingController(text: user.password),
                        onChanged: (val) {
                          user.password = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is Empty';
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

                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                              "Already have Account ?",
                              style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
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
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: 25,
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