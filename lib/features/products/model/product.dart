class Product {
  String? name;
  String? desc;
  String? price;
  String? photoUrl;

  Product({this.name, this.desc, this.price, this.photoUrl});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['desc'] = desc;
    data['price'] = price;
    data['photoUrl'] = photoUrl;
    return data;
  }
}