class PatientData {
  String? name;
  String? image;
  String? age;
  String? email;
  String? phone;
  String? city;
  String? uid;

  PatientData({
    this.name,
    this.image,
    this.age,
    this.email,
    this.phone,
    this.city,
    this.uid,
  });

  PatientData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    age = json['age'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['age'] = age;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['uid'] = uid;
    return data;
  }

  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (image != null) data['image'] = image;
    if (age != null) data['age'] = age;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (city != null) data['city'] = city;
    return data;
  }
}