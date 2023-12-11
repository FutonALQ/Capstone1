import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChange,
    required this.onCancel,
  });
  final TextEditingController controller;
  final Function(String query) onChange;
  final Function() onCancel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.06,
      child: TextField(
        onChanged: onChange,
        controller: controller,
        textAlignVertical: const TextAlignVertical(y: 1),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: 'Search for people',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close_outlined,
              color: Colors.black54,
            ),
            onPressed: onCancel,
          ),
        ),
      ),
    );
  }
}
