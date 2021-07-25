part 'Employee.g.dart';
class Employee{
   int id;
   String firstname;
   String lastname;
   String job;


  Employee(this.id,this.firstname, this.lastname, this.job);

   factory Employee.fromJson(Map<String,dynamic> json) => _$EmployeeFromJson(json);
   Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}