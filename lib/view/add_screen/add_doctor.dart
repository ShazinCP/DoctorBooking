import 'package:flutter/material.dart';
import 'package:kailasoft_task/view/add_screen/widgets/textfield_widget.dart';
import 'package:kailasoft_task/controller/doctor_provider.dart';
import 'package:kailasoft_task/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<DoctorProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                      const Text(
                        'Add Doctor',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[200],
                    child: const Stack(
                      children: [
                        Icon(Icons.person, size: 90),
                        Positioned(
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
                  const SizedBox(height: 40),
                  TextfieldWidget(
                    controller: provider.nameController,
                    labelText: 'Full Name',
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
                      value: provider.district,
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
                  ),
                  const SizedBox(height: 20),
                  TextfieldWidget(
                    controller: provider.phoneNumberController,
                    labelText: 'Phone Number',
                  ),
                  const SizedBox(height: 20),
                  // type(),
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
                      value: provider.gender,
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Padding type() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Consumer<DoctorProvider>(
      builder: (context, provider, child) {
        return Container(
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
              value: provider.gender,

              onChanged: ((value) {
                provider.setGender(value!);
              }),
              items: provider.genderItems
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: InputBorder.none,
              ),
              // hint: const Text(
              //   'Gender',
              //   style: TextStyle(color: Colors.grey),
              // ),
              // dropdownColor: Colors.white,
              // isExpanded: true,
            ));
      },
    ),
  );
}
