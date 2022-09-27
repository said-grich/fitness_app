import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel extends Equatable {
  final String id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? photo;
  const UserModel(
      {required this.id, this.fullName, this.email, this.password, this.photo});
  static const empty = UserModel(id: '');
  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        photo      ];
}
