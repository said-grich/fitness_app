import 'dart:convert';

import 'package:equatable/equatable.dart';

CommnetModel commnetModelFromJson(String str) =>
    CommnetModel.fromJson(json.decode(str));

String commnetModelToJson(CommnetModel data) => json.encode(data.toJson());

class CommnetModel  extends Equatable{
  CommnetModel({
    required this.userId,
    required this.photoUrl,
    required this.usernname,
    required this.comment,
  });

  String userId;
  String photoUrl;
  String usernname;
  String comment;

  factory CommnetModel.fromJson(Map<String, dynamic> json) => CommnetModel(
        userId: json["userId"],
        photoUrl: json["photoUrl"],
        usernname: json["usernname"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "photoUrl": photoUrl,
        "usernname": usernname,
        "comment": comment,
      };
      
        @override
        List<Object?> get props =>[userId,photoUrl,usernname,comment];
}
