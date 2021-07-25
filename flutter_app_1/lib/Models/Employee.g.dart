part of 'Employee.dart';


Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
    json['id']as int ,
    json['firstname'] as String,
    json['lastname'] as String,
    json['job'] as String,
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'id': instance.id,
  'firstname': instance.firstname,
  'lastname': instance.lastname,
  'job': instance.job,

};