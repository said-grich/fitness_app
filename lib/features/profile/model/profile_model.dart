import 'dart:convert';

ProfileModel profileFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
     this.age,
     this.email,
     this.fullname,
    required this.id,
     this.length,
     this.phone,
     this.photoUrl,
     this.poids,
     this.role,
     this.sex,
  });
  static  final empty =  ProfileModel(id: '');
  bool get isEmpty => this == ProfileModel.empty;
  bool get isNotEmpty => this != ProfileModel.empty;
  String? age;
  String? email;
  String? fullname;
  String id;
  String? length;
  String? phone;
  String? photoUrl;
  String? poids;
  String? role;
  String? sex;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        age: json["age"],
        email: json["email"],
        fullname: json["fullname"],
        id: json["id"],
        length: json["length"],
        phone: json["phone"],
        photoUrl: json["photoUrl"],
        poids: json["poids"],
        role: json["role"],
        sex: json["sex"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "email": email,
        "fullname": fullname,
        "id": id,
        "length": length,
        "phone": phone,
        "photoUrl": photoUrl,
        "poids": poids,
        "role": role,
        "sex": sex,
      };
}
