import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kailasoft_task/controller/doctor_provider.dart';
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
    if (widget.doctor != null) {
      provider.nameController.text = widget.doctor!.name ?? '';
      provider.qualificationController.text =
          widget.doctor!.qualification ?? '';
      provider.emailController.text = widget.doctor!.email ?? '';
      provider.phoneNumberController.text = widget.doctor!.phonenumber ?? '';
      provider.selectedDistrict = widget.doctor!.district;
      provider.selectedGender = widget.doctor!.gender;
      if (widget.doctor!.image != null) {
        provider.setSelectedImage(File(widget.doctor!.image!));
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final imageProvider = Provider.of<DoctorProvider>(context, listen: false);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imageProvider.setSelectedImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<DoctorProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
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
                            provider.setSelectedImage(null);
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
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
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
                        backgroundColor: Colors.grey[200],
                        backgroundImage: provider.selectedImage != null
                            ? FileImage(provider.selectedImage!)
                            : null,
                        child: Stack(
                          children: [
                            if (provider.selectedImage == null)
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
                        if (widget.doctor == null) {
                          provider.addDoctor();
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
                        provider.setSelectedImage(null);
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
              );
            },
          ),
        ),
      ),
    );
  }
}
