import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  static const String collectionName = 'users';
  String id; // to access specific user
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  // json to object
  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String, name: data['name'], email: data['email']);

  // object to json
  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
/*
if i want to store user information during the app tabs:
1- provider => more than 2 screens
2- navigation with args => 2 screens
3- shared preferences

 */