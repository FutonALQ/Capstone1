import 'package:flutter/material.dart';

Widget buildStyledTextField({
  required TextEditingController controller,
  required String labelText,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: keyboardType,
    style: TextStyle(color: Color(0xffFFB703)),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle:
          TextStyle(color: Color(0xff023047), fontWeight: FontWeight.w200),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffFFB703), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff8ECAE6), width: 1),
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
