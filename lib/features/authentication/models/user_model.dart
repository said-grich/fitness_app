import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel extends Equatable {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? sex;
  final String? poids;
  final String? age;
  final String? lenght;
  final String? phone;
  final String? photo;
  final String? role;
  const UserModel({this.role, this.sex, this.poids, this.age, this.lenght, this.phone, 
      required this.id, this.fullName, this.email, this.password, this.photo});


  static const empty = UserModel(id: '');
  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        photo, sex, poids, age, lenght, role, phone];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'sex': sex,
      'poids': poids,
      'age': age,
      'lenght': lenght,
      'phone': phone,
      'photo': photo,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      sex: map['sex'] != null ? map['sex'] as String : null,
      poids: map['poids'] != null ? map['poids'] as String : null,
      age: map['age'] != null ? map['age'] as String : null,
      lenght: map['lenght'] != null ? map['lenght'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
