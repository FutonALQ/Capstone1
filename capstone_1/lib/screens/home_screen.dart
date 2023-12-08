import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/screens/profile_screen.dart';
import 'package:capstone_1/widgets/trip_grid_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedChipIndex = 0;
  final List<String> category = ["All", "sport", "art", "Education", "fun"];
  final List<IconData> icons = [
    Icons.clear_all_sharp,
    Icons.sports_baseball_outlined,
    Icons.art_track,
    Icons.cast_for_education,
    Icons.bike_scooter
  ];
  String selectedCategory = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 22.0, left: 24, right: 24),
      child: ListView(
        // shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 163,
                    child: Text(
                      ' Hello 👋 ${currentUser?.name}',
                      style: const TextStyle(
                        color: Color(0xff023047),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFFDE7254),
                      ),
                      Text(
                        " Saudi Arabia, ${currentUser!.city!}",
                        style: const TextStyle(
                          color: Color(0xFFDE7254),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()));
                },
                child: ClipOval(
                  child: Image.network(
                    currentUser!.imageUrl!,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Discover Trips ',
            style: TextStyle(
              color: Color.fromARGB(208, 2, 48, 71),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
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
                    avatar: Icon(icons[chipIndex]),
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
          TripGridView(selectedCategory: selectedCategory)
        ],
      ),
    ));
  }
}
