import 'dart:convert';

import 'package:equatable/equatable.dart';

DiscussionModel discussionModelFromJson(String str) =>
    DiscussionModel.fromJson(json.decode(str));

String discussionModelToJson(DiscussionModel data) =>
    json.encode(data.toJson());

class DiscussionModel extends Equatable{
  DiscussionModel({
    required this.userId,
     required this.title,
    required this.desc,
    required this.photourl,
  });

  String userId;
  String title;
  String desc;
  String photourl;

  factory DiscussionModel.fromJson(Map<String, dynamic> json) =>
      DiscussionModel(
        userId: json["userId"],
        title: json["title"],
        desc: json["desc"],
        photourl: json["photourl"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "desc": desc,
        "photourl": photourl,
      };
      
        @override
        List<Object?> get props => [photourl,desc,title,userId];
}
