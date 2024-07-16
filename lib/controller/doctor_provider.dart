import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kailasoft_task/model/doctor_model.dart';
import 'package:kailasoft_task/services/doctor_services.dart';

class DoctorProvider extends ChangeNotifier {
  DoctorProvider() {
    fetchDoctor();
  }

  String? selectedDistrict;
  String? selectedGender;
  String? selectedFilterDistrict;
  String? selectedFilterGender;
  TextEditingController nameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  File? selectedImage;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> genderItems = ['Male', 'Female', 'Other'];
  final List<String> districtList = [
    'Ernakulam',
    'Malappuram',
    'Kozhikode',
    'Kannur'
  ];

  List<DoctorModel> doctors = [];

  void setDistrict(String district) {
    selectedDistrict = district;
    notifyListeners();
  }

  void setGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void filterDistrict(String district) {
    selectedFilterDistrict = district;
    notifyListeners();
  }

  void filterGender(String gender) {
    selectedFilterGender = gender;
    notifyListeners();
  }

  void setSelectedImage(File? image) {
    selectedImage = image;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final DoctorServices doctorServices = DoctorServices();

  Future<void> fetchDoctor() async {
    doctors = await doctorServices.fetchDoctors();
    notifyListeners();
  }

  void addDoctor() async {
    final doctor = DoctorModel(
      id: "",
      name: nameController.text,
      qualification: qualificationController.text,
      district: selectedDistrict,
      email: emailController.text,
      gender: selectedGender,
      phonenumber: phoneNumberController.text,
      image: selectedImage?.path,
    );
    doctorServices.addDoctor(doctor);
    await fetchDoctor();
    notifyListeners();
  }

  Future<void> deleteDoctor(String docId) async {
    doctorServices.deleteDoctor(docId);
    await fetchDoctor();
    notifyListeners();
  }

  void updateDoctor(String docId) async {
    final doctor = DoctorModel(
      id: docId,
      name: nameController.text,
      qualification: qualificationController.text,
      district: selectedDistrict,
      email: emailController.text,
      gender: selectedGender,
      phonenumber: phoneNumberController.text,
      image: selectedImage?.path,
    );
    doctorServices.updateDoctor(doctor);
    await fetchDoctor();
    notifyListeners();
  }
  
}