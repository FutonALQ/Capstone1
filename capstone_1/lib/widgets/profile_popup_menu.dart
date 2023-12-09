import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePopUpMenu extends StatelessWidget {
  ProfilePopUpMenu(
      {super.key,
      required this.editProfile,
      required this.signout,
      required this.mode,
      required this.language});
  PopupMenuItem editProfile;
  PopupMenuItem signout;
  PopupMenuItem mode;
  PopupMenuItem language;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => [editProfile, mode, language, signout]);
  }
}
