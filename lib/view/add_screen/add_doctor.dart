import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kailasoft_task/controller/doctor_provider.dart';
import 'package:kailasoft_task/controller/image_provider.dart';
import 'package:kailasoft_task/model/doctor_model.dart';
import 'package:kailasoft_task/view/add_screen/widgets/textfield_widget.dart';
import 'package:kailasoft_task/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class AddandEditDoctor extends StatefulWidget {
  final DoctorModel? doctor;

  const AddandEditDoctor({super.key, this.doctor});

  @override
  State<AddandEditDoctor> createState() => _AddandEditDoctorState();
}

class _AddandEditDoctorState extends State<AddandEditDoctor> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DoctorProvider>(context, listen: false);
    final provider2 = Provider.of<StorageProvider>(context, listen: false);
    if (widget.doctor != null) {
      provider.nameController.text = widget.doctor!.name ?? '';
      provider.qualificationController.text =
          widget.doctor!.qualification ?? '';
      provider.emailController.text = widget.doctor!.email ?? '';
      provider.phoneNumberController.text = widget.doctor!.phonenumber ?? '';
      provider.selectedDistrict = widget.doctor!.district;
      provider.selectedGender = widget.doctor!.gender;
      if (widget.doctor!.image != null) {
        provider2.setSelectedImage(File(widget.doctor!.image!));
      }
    }
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer2<DoctorProvider, StorageProvider>(
            builder: (context, provider, provider2, child) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                              provider.nameController.clear();
                              provider.qualificationController.clear();
                              provider.emailController.clear();
                              provider.phoneNumberController.clear();
                              provider.selectedDistrict = null;
                              provider.selectedGender = null;
                              provider2.setSelectedImage(null);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.doctor == null
                                    ? 'Add Doctor'
                                    : 'Edit Doctor',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (widget.doctor != null)
                            IconButton(
                              onPressed: () async {
                                if (widget.doctor!.id != null) {
                                  await provider.deleteDoctor(widget.doctor!.id!);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                  provider.nameController.clear();
                                  provider.qualificationController.clear();
                                  provider.emailController.clear();
                                  provider.phoneNumberController.clear();
                                  provider.selectedDistrict = null;
                                  provider.selectedGender = null;
                                  provider2.setSelectedImage(null);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        provider2.pickImage(context);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Gallery'),
                                      onTap: () {
                                        provider2.pickImage(context);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
                          backgroundImage: provider2.imageBytes != null
                              ? MemoryImage(provider2.imageBytes!)
                              : null,
                          child: Stack(
                            children: [
                              if (provider2.imageBytes == null)
                                const Icon(Icons.person, size: 90),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextfieldWidget(
                        controller: provider.nameController,
                        labelText: 'Full Name',
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      TextfieldWidget(
                        controller: provider.qualificationController,
                        labelText: 'Qualification',
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4F7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFF2F4F7),
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: provider.selectedDistrict,
                          onChanged: (newValue) {
                            provider.setDistrict(newValue!);
                          },
                          items: provider.districtList
                              .map((district) => DropdownMenuItem(
                                    value: district,
                                    child: Text(district),
                                  ))
                              .toList(),
                          decoration: const InputDecoration(
                            hintText: 'District',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextfieldWidget(
                        controller: provider.emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => _validateEmail(value),
                      ),
                      const SizedBox(height: 20),
                      TextfieldWidget(
                        controller: provider.phoneNumberController,
                        labelText: 'Phone Number',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4F7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFF2F4F7),
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: provider.selectedGender,
                          onChanged: (newValue) {
                            provider.setGender(newValue!);
                          },
                          items: provider.genderItems
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          decoration: const InputDecoration(
                            hintText: 'Gender',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      ElevatedButton(
                        onPressed: () {
                          if (widget.doctor == null && _formKey.currentState!.validate()) {
                            provider.addDoctor();
                            provider2.uploadBannerImage(context);
                          } else {
                            if (widget.doctor!.id != null) {
                              provider.updateDoctor(widget.doctor!.id!);
                            }
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                          // Clear fields and reset selections
                          provider.nameController.clear();
                          provider.qualificationController.clear();
                          provider.emailController.clear();
                          provider.phoneNumberController.clear();
                          provider.selectedDistrict = null;
                          provider.selectedGender = null;
                          provider2.setSelectedImage(null);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          widget.doctor == null ? 'SAVE' : 'UPDATE',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  

     String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    const emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
}
