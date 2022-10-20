import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
    PlanModel({
     required   this.name,
    required    this.dure,
    required    this.desc,
     required   this.steps,
    });

    String name;
    String dure;
    String desc;
    List<Step> steps;

    factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        name: json["name"],
        dure: json["dure"],
        desc: json["desc"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "dure": dure,
        "desc": desc,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    };
}

class Step {
    Step({ required
        this.stepDesc,
    });

    String stepDesc;

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        stepDesc: json["stepDesc"],
    );

    Map<String, dynamic> toJson() => {
        "stepDesc": stepDesc,
    };
}
