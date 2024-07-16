class DoctorModel {
  String? name;
  String? district;
  String? qualification;
  String? email;
  String? phonenumber;
  String? gender;
  String? image;
  String? id;

  DoctorModel({
    this.name,
    this.qualification,
    this.district,
    this.email,
    this.phonenumber,
    this.gender,
    this.image,
    this.id,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map, String id) {
    return DoctorModel(
      id: id,
      name: map['name'] ?? '',
      qualification: map['qualification'] ?? '',
      district: map['place'] ?? '',
      email: map['email'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'qualification': qualification,
      'place': district,
      'email': email,
      'phonenumber': phonenumber,
      'gender': gender,
      'image': image,
    };
  }
}
