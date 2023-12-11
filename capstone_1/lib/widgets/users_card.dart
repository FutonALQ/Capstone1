import 'package:capstone_1/models/user.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UsersCard extends StatelessWidget {
  UsersCard(
      {super.key,
      required this.onTap,
      required this.followOnPressed,
      this.buttonText = 'Follow',
      required this.user,
      this.buttonTextColor = const Color(0xff023047)});

  Function() onTap;

  Function() followOnPressed;
  String buttonText;
  Color buttonTextColor;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffe6eefa),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      user.imageUrl!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 14),
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name!.trim(),
                            softWrap: true,
                            style: const TextStyle(
                                color: Color(0xff023047),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " ${user.city!}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                onPressed: followOnPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: buttonText == 'Unfollow'
                        ? const Color.fromARGB(196, 244, 67, 54)
                        : buttonTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
