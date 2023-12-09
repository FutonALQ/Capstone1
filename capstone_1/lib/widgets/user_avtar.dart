import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserAvatar extends StatelessWidget {
  UserAvatar({super.key, required this.src});
  String src;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: MediaQuery.sizeOf(context).height * 0.13,
        width: MediaQuery.sizeOf(context).height * 0.13,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Image.network(
          src,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
