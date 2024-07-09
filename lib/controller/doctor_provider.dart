import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  String? district;
  String? gender;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final List<String> genderItems = ['Male', 'Female', 'Other'];
  final List<String> districtList = [
    'Ernakulam',
    'Malappuram',
    'Kozhikode',
    'Kannur'
  ];

  void setDistrict(String district) {
    district = district;
    notifyListeners();
  }

  void setGender(String gender) {
    gender = gender;
    notifyListeners();
  }
}
