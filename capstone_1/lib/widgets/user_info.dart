import 'package:capstone_1/widgets/profile_info_row.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInfo extends StatelessWidget {
  UserInfo({
    super.key,
    required this.age,
    required this.city,
    required this.name,
    required this.phone,
  });
  String name;
  String city;
  String phone;
  String age;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileInfoRow(
          text: name.toString(),
          black: true,
        ),
        ProfileInfoRow(
          text: city.toString(),
        ),
        ProfileInfoRow(
          text: phone.toString(),
        ),
        ProfileInfoRow(
          text: age.toString(),
        ),
      ],
    );
  }
}
