import 'dart:ffi';

class DoctorData {
  String? name;
  String? image;
  String? specialization;
  String? email;
  String? phone1;
  String? phone2;
  String? bio;
  String? openHour;
  String? closeHour;
  String? address;
  String? uid;
  Float? rating;
  String? cost;

  DoctorData({
    this.name,
    this.image,
    this.specialization,
    this.email,
    this.phone1,
    this.phone2,
    this.bio,
    this.openHour,
    this.closeHour,
    this.address,
    this.uid,
    this.rating,
    this.cost,
  });

  DoctorData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    specialization = json['specialization'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    bio = json['bio'];
    openHour = json['openHour'];
    closeHour = json['closeHour'];
    address = json['address'];
    uid = json['uid'];
    rating = json['rating'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['specialization'] = specialization;
    data['email'] = email;
    data['phone1'] = phone1;
    data['phone2'] = phone2;
    data['bio'] = bio;
    data['openHour'] = openHour;
    data['closeHour'] = closeHour;
    data['address'] = address;
    data['uid'] = uid;
    data['rating'] = rating;
    data['cost'] = cost;

    return data;
  }

  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (image != null) data['image'] = image;
    if (specialization != null) data['specialization'] = specialization;
    if (email != null) data['email'] = email;
    if (phone1 != null) data['phone1'] = phone1;
    if (phone1 != null) data['phone2'] = phone2;
    if (bio != null) data['bio'] = bio;
    if (openHour != null) data['openHour'] = openHour;
    if (closeHour != null) data['closeHour'] = closeHour;
    if (address != null) data['address'] = address;
    if (rating != null) data['rating'] = rating;
    if (cost != null) data['cost'] = cost;

    return data;
  }
}
