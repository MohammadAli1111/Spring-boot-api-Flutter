import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_1/Models/Employee.dart';
import 'package:flutter_app_1/Models/Jwt.dart';
import 'package:flutter_app_1/Models/User.dart';
import 'package:flutter_app_1/Views/AddEmployee.dart';
import 'package:flutter_app_1/Views/Register.dart';
import 'package:http/http.dart' as http;
import 'EditEmployee.dart';
import 'Login.dart';

class DashboardApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return Dashboard();
  }

}
class Dashboard extends State<DashboardApp> {
  static const route="/dashboard";
  Future<User> futureUser;
  var jsonMap;

  Future edit(int id) async {
    var res= await http.get("http://10.0.2.2:8080/api/v1/user/getEmployee/${id}",
        headers:{"Authorization":"Bearer ${Jwt.token}"});
    var jsonMap = json.decode(res.body);
    if(jsonMap!=null){
     Navigator.pushNamed(context, EditEmployee.route,arguments: jsonMap);
    }

  }
  Future delete(int id) async {
    var res= await http.get("http://10.0.2.2:8080/api/v1/user/delete/${id}",
        headers:{"Authorization":"Bearer ${Jwt.token}"});
    setState(() {
      jsonMap = json.decode(res.body);
    });


  }

  Future<User> getuser()async{
    http.Response resUser= await http.get("http://10.0.2.2:8080/api/v1/user/profile",
        headers:{"Authorization":"Bearer ${Jwt.token}"});
    if(resUser.statusCode==200){
        return User.fromJson(json.decode(resUser.body));
    }else{
      //error
      throw Exception("Error in method getuser()");
    }
  }


  @override
  void initState() {
    super.initState();
    futureUser=getuser();

  }

  @override
  Widget build(BuildContext context) {
    if(jsonMap==null) {
      jsonMap = ModalRoute
          .of(context)
          .settings
          .arguments;
    }
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                    bottomRight:Radius.circular(20)),

                ),

                  child:  FutureBuilder<User>(
                    future: futureUser,
                    // ignore: missing_return
                    builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                   if( snapshot.connectionState == ConnectionState.waiting){
                    return  Center(child: Text('Please wait its loading...'));
                   }else{
                        if(snapshot.hasData){
                          return Center(
                            child:Column(
                            children: [
                              Icon(Icons.person,color: Colors.white,size: 50,),
                              Text("${snapshot.data.name}",style: TextStyle(color: Colors.white,fontSize: 18),),
                              SizedBox(height: 5,),
                              Text("${snapshot.data.email}",style: TextStyle(color: Colors.white,fontSize: 18),),
                            ],
                          )
                          );
                        }else if(snapshot.hasError){
                          return Text("Error");
                        }else{
                          CircularProgressIndicator();
                        }
    }
                    },
                  ),
              ),
              ListTile(
                title: Text("Add Employee",
                  style: TextStyle(color: Colors.blue ,fontSize: 18),),
                leading: Icon(Icons.person_add,color: Colors.blue,),
                onTap: (){
                  //Action
                  Navigator.pushNamed(context, AddEmployee.route);
                },
              )
             ,

              ListTile(
                title: Text("Login",
                  style: TextStyle(color: Colors.blue ,fontSize: 18),),
                leading: Icon(Icons.verified_user,color: Colors.blue,),
                onTap: (){
                  //Action
                  Navigator.pushNamed(context, Login.route);
                },
              ),

              ListTile(
                title: Text("Logout",
                  style: TextStyle(color: Colors.blue ,fontSize: 18),),
                leading: Icon(Icons.logout,color: Colors.blue,),
                onTap: (){
                  //Action

                  Navigator.of(context).popUntil(ModalRoute.withName(Login.route));
                },
              )

            ],
          ),
        ),
        appBar: AppBar(
            title: Text("App"),


        ),
        body:GridView.count(
          padding: EdgeInsets.all(2),
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing:2 ,


children: (jsonMap as List).map((element) {
  Employee employee=Employee.fromJson(element);
  return Container(

    decoration: BoxDecoration(color: Colors.blue,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30)
          ,topRight:  Radius.circular(30)),

    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       Container(
         decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),
           shape: BoxShape.circle,


         ),
         child:  Icon(Icons.person,color: Colors.white,size: 50,),
       ),
        Text("Full Name :${employee.firstname +"  "+ employee.lastname}",),
         Text("Job : ${employee.job}",),
        Container(

          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30)
            ,topRight:  Radius.circular(30)),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.open_in_new,color: Colors.white,),
                  onPressed: (){
                    edit(employee.id);
                  }

              ),
              IconButton(icon: Icon(Icons.delete,color: Colors.white,),
                  onPressed: (){
                    delete(employee.id);
                  }

              ),
            ],
          ),
        ),


      ],
    ),

  );

}).toList(),


        ),
      ),

    );
  }



}