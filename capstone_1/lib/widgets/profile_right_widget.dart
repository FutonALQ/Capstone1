import 'package:flutter/material.dart';

class ProfileRightWidget extends StatelessWidget {
  const ProfileRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        Text('MEOW MEOW'),
      ],
    );
  }
}
