import 'package:flutter/material.dart';

Widget buildTripContainer({
  required String title,
  IconData? iconData,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // if (iconData != null) SizedBox(width: 10),
            // if (iconData != null)
            Icon(
              iconData,
              color: Colors.green[50],
              size: 24,
            ),
          ],
        ),
      ),
    ),
  );
}
