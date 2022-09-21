import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel extends Equatable {
  String uid;
  String fullname;
  String email;
  String password;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.password,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  List<Object?> get props => [uid,fullname,email,password];
}
