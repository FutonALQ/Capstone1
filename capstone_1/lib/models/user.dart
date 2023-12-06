class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? age;
  String? city;
  String? password;
  String? social;
  String? user_uuid;
  String? gender;
  String? imageUrl;
  String? username;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.age,
      this.city,
      this.password,
      this.social,
      this.user_uuid,
      this.gender,
      this.imageUrl,
      this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    age = json['age'];
    city = json['city'];
    password = json['password'];
    social = json['social'];
    user_uuid = json['user_uuid'];
    gender = json['gender'];
    imageUrl = json['image_url'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['age'] = age;
    data['city'] = city;
    data['password'] = password;
    data['social'] = social;
    data['user_uuid'] = user_uuid;
    data['gender'] = gender;
    data['image_url'] = imageUrl;
    data['username'] = username;
    return data;
  }
}
