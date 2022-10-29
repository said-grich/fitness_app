import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  PlanModel({
    required this.name,
    required this.category,
    required this.desc,
    required this.steps,
  });

  String name;
  String category;
  String desc;
  List<String> steps;

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        name: json["name"],
        category: json["category"],
        desc: json["desc"],
        steps: List<String>.from(json["steps"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "desc": desc,
        "steps": List<dynamic>.from(steps),
      };
}


