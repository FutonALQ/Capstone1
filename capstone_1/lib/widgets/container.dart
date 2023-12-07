import 'package:capstone_1/globals/global_user.dart';
import 'package:flutter/material.dart';

class TripCountener extends StatelessWidget {
  const TripCountener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      alignment: Alignment.topCenter,
      width: 150,
      height: 272,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(70),
            topRight: Radius.circular(70),
            bottomLeft: Radius.circular(27),
            bottomRight: Radius.circular(27),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              "https://images.pexels.com/photos/1371360/pexels-photo-1371360.jpeg?cs=srgb&dl=pexels-te-lensfix-1371360.jpg&fm=jpg",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            currentUser!.name ?? "-",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            currentUser!.phone.toString(),
            style: const TextStyle(
              color: Color(0xFF637663),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
