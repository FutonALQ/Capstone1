import 'package:capstone_1/widgets/following_trip_countener.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key});

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  int selectedChipIndex = 0;
  String selectedCategory = "All";
  @override
  Widget build(BuildContext context) {
    final List<String> category = [
      "All",
      "sport",
      "art",
      "education",
      "hangout"
    ];
    final List<IconData> icons = [
      Icons.clear_all_sharp,
      Icons.sports_baseball,
      FontAwesome.paintbrush,
      FontAwesome.book,
      FontAwesome.mug_saucer,
    ];

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 24, right: 24),
      child: ListView(
        children: [
          const Text(
            'Discover Followers Trips ',
            style: TextStyle(
              color: Color.fromARGB(208, 2, 48, 71),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: category.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isEven) {
                  final chipIndex = index ~/ 2;
                  return ChoiceChip(
                    showCheckmark: false,
                    avatar: Icon(icons[chipIndex],
                        color: const Color.fromARGB(77, 0, 0, 0)),
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE7E7EF)),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    label: Text(category[chipIndex]),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: selectedChipIndex == chipIndex
                          ? Colors.white
                          : Colors.black,
                    ),
                    selected: selectedChipIndex == chipIndex,
                    selectedColor: const Color(0xff8ECAE6),
                    onSelected: (selected) {
                      setState(() {
                        selectedChipIndex = selected ? chipIndex : -1;
                        selectedCategory = category[chipIndex];
                      });
                    },
                  );
                } else {
                  return const SizedBox(width: 8);
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FollowingTripGridView(selectedCategory: selectedCategory)
        ],
      ),
    ));
  }
}
