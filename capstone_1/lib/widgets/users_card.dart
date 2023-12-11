import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UsersCard extends StatelessWidget {
  UsersCard({
    super.key,
    required this.onTap,
    required this.src,
    required this.name,
    required this.phone,
    required this.chatOnPressed,
    required this.followOnPressed,
    this.buttonText = 'follow',
    this.buttonTextColor = Colors.deepPurple,
  });
  Function() onTap;
  String src;
  String name;
  String phone;
  Function() chatOnPressed;
  Function() followOnPressed;
  String buttonText;
  Color buttonTextColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffe6eefa),
          // color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Image.network(
                  src,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.trim(),
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: chatOnPressed,
                    icon: const Icon(
                      Icons.chat_bubble,
                      color: Colors.blue,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: followOnPressed,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: buttonTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
