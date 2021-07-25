part of 'User.dart';


User _$UserFromJson(Map<String, dynamic> json) => User(
    json['id']as int ,
    json["name"] as String,
    json["email"] as String,
     json["password"] as String
  );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  "name": "${instance.name}",
  "email": "${instance.email}",
  "password": "${instance.password}",
};