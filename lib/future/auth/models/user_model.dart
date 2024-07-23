import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String name;
  late String phoneNumber;
  late String countryCode;
  late String gender;
  late int age;
  late String password;

  UserModel({
    required this.age,
    required this.countryCode,
    required this.gender,
    required this.id,
    required this.name,
    required this.password,
    required this.phoneNumber,
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    id = json["user_id"];
    name = json["name"];
    phoneNumber = json["phone_number"];
    countryCode = json["country_code"];
    gender = json["gender"];
    age = json["age"];
    password = json["password"];
  }
  UserModel.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.get('user_id');
    name = snapshot.get('name');
    phoneNumber = snapshot.get('phone_number');
    password = snapshot.get('password');
    countryCode = snapshot.get('country_code');
    age = snapshot.get('age') as int;
    gender = snapshot.get('gender');
  }
  Map<String, dynamic> toMap() {
    return {
      "user_id": id,
      "phone_number": phoneNumber,
      "age": age,
      "gender": gender,
      "name": name,
      "country_code": countryCode,
      "password": password,
    };
  }
}
