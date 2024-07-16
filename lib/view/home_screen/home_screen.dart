import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kailasoft_task/controller/doctor_provider.dart';
import 'package:kailasoft_task/controller/image_provider.dart';
import 'package:kailasoft_task/model/doctor_model.dart';
import 'package:kailasoft_task/view/add_screen/add_doctor.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DoctorProvider>(context, listen: false);
    provider.fetchDoctor();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<DoctorProvider>(
            builder: (context, homeProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          homeProvider.fetchDoctor();
                        },
                        child: const Text(
                          'Doctors',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(homeProvider.selectedFilterGender ??
                                  'Gender'),
                              items: ['Male', 'Female', 'Other']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                homeProvider.filterGender(newValue!);
                              },
                              value: homeProvider.selectedFilterGender,
                            ),
                          ),
                          const SizedBox(width: 12),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(homeProvider.selectedFilterDistrict ??
                                  'District'),
                              items: [
                                'Ernakulam',
                                'Malappuram',
                                'Kozhikode',
                                'Kannur',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                homeProvider.filterDistrict(newValue!);
                              },
                              value: homeProvider.selectedFilterDistrict,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Consumer2<DoctorProvider,StorageProvider>(
                      builder: (context, provider,provider2, child) {
                        if (provider.doctors.isEmpty) {
                          return const Center(
                            child: Text('No doctors added'),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: provider.fetchDoctor,
                          child: ListView.builder(
                            itemCount: provider.doctors.length,
                            itemBuilder: (context, index) {
                              final DoctorModel doctor =
                                  provider.doctors.reversed.toList()[index];
                              if (provider.selectedFilterGender != null &&
                                  doctor.gender !=
                                      provider.selectedFilterGender) {
                                return const SizedBox.shrink();
                              }
                              if (provider.selectedFilterDistrict != null &&
                                  doctor.district !=
                                      provider.selectedFilterDistrict) {
                                return const SizedBox.shrink();
                              }
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: doctor.image != null && doctor.image!.isNotEmpty
      ? Image.memory(
          base64Decode(doctor.image!),
          width: 80,
          height: 105,
          fit: BoxFit.cover,
        )
      : const Icon(Icons.person, size: 75),
),


                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctor.name.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              doctor.qualification.toString(),
                                              style:
                                                  const TextStyle(fontSize: 8),
                                            ),
                                            Text(
                                              doctor.district.toString(),
                                              style:
                                                  const TextStyle(fontSize: 8),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                AddandEditDoctor(
                                                    doctor: doctor),
                                          ));
                                          log('${doctor.image}');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF019744),
                                          minimumSize: const Size(50, 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'Edit Profile',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF019744),
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddandEditDoctor(),
            ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
        bottomNavigationBar: Consumer<DoctorProvider>(
          builder: (context, doctorProvider, child) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_rounded),
                  label: 'Appointment',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description),
                  label: 'Prescription',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: doctorProvider.selectedIndex,
              selectedItemColor: const Color(0xFF019744),
              unselectedItemColor: const Color(0xFF98A3B3),
              onTap: (index) {
                doctorProvider.setSelectedIndex(index);
              },
            );
          },
        ),
      ),
    );
  }
}
