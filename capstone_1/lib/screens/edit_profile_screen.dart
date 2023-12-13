import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_event.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/widgets/text_field.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedCity = 'Riyadh';
  String imageUrl =
      'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-shelby-gt500-02-1636734552.jpg';
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: currentUser!.name);
    TextEditingController emailController =
        TextEditingController(text: 'khmcnybcgykstpb@wireconnected.com');
    TextEditingController passwordController =
        TextEditingController(text: '000000');
    TextEditingController phoneController =
        TextEditingController(text: '0547893510');
    TextEditingController ageController =
        TextEditingController(text: currentUser!.age.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            UserAvatar(
              height: 0.19,
              src:
                  'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-shelby-gt500-02-1636734552.jpg',
            ),
            const SizedBox(height: 30),
            AddTextField(
              label: 'Name',
              hint: 'your name',
              isPassword: false,
              controller: nameController,
              icon: Icons.person,
              isAge: false,
            ),
            const SizedBox(height: 30),
            AddTextField(
              label: 'Email Adress',
              hint: 'your email',
              isPassword: false,
              controller: emailController,
              icon: Icons.email,
              isAge: false,
            ),
            const SizedBox(height: 30),
            AddTextField(
              label: 'Phone',
              hint: 'your phone number',
              isPassword: false,
              controller: phoneController,
              icon: Icons.phone,
              isAge: true,
            ),
            const SizedBox(height: 30),
            AddTextField(
              label: 'Age',
              hint: 'your age',
              isPassword: false,
              controller: ageController,
              icon: Icons.numbers,
              isAge: true,
            ),
            const SizedBox(height: 30),
            AddTextField(
              label: 'Change Password',
              hint: 'your password',
              isPassword: true,
              controller: passwordController,
              icon: Icons.password,
              isAge: false,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select City:",
                    style: TextStyle(fontSize: 16, color: Color(0xff219EBC)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: DropdownButton<String>(
                      value: selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCity = newValue!;
                          print(selectedCity);
                        });
                      },
                      items: <String>['Riyadh', 'Jeddah', 'Dammam']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color(0xff219EBC)),
                      iconSize: 36,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: const Color(0xff219EBC),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                context.read<EditProfileBloc>().add(UpdateProfileEvent(
                    imageUrl: imageUrl.trim(),
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    age: ageController.text.trim(),
                    password: passwordController.text.trim(),
                    city: selectedCity.trim()));
              },
              child: Container(
                width: 330,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff8ECAE6)),
                child: const Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
