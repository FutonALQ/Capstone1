import 'package:capstone_1/screens/tripdeatail_screen.dart';
import 'package:flutter/material.dart';

class TripListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Followers'),
      ),
      body: ListView(
        children: [
          TripContainer(
            userName: 'User 1',
            imageUrl: 'lib/assets/images/testtrip.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TripDetailsScreen(
                          userName: 'User 1',
                          tripTitle: 'Title',
                          tripDescription: 'Descrpitoin',
                          tripBudget: '100',
                          tripLocation: 'Riyadh',
                          tripDate: '4/1/2024',
                          tripGovernor: 'user',
                          tripImageUrl: 'lib/assets/images/testtrip.jpg',
                        )),
              );
            },
          ),
          SizedBox(
            height: 1,
          ),
          TripContainer(
            userName: 'User 2',
            imageUrl: 'lib/assets/images/testtrip.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TripDetailsScreen(
                          userName: 'User 2',
                          tripTitle: 'Title',
                          tripDescription: 'Descrpitoin',
                          tripBudget: '100',
                          tripLocation: 'Riyadh',
                          tripDate: '4/1/2024',
                          tripGovernor: 'user',
                          tripImageUrl: 'lib/assets/images/testtrip.jpg',
                        )),
              );
            },
          ),
          SizedBox(
            height: 1,
          ),
          TripContainer(
            userName: 'User 2',
            imageUrl: 'lib/assets/images/testtrip.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TripDetailsScreen(
                          userName: 'User 2',
                          tripTitle: 'Title',
                          tripDescription: 'Descrpitoin',
                          tripBudget: '100',
                          tripLocation: 'Riyadh',
                          tripDate: '4/1/2024',
                          tripGovernor: 'user',
                          tripImageUrl: 'lib/assets/images/testtrip.jpg',
                        )),
              );
            },
          ),
          TripContainer(
            userName: 'User 2',
            imageUrl: 'lib/assets/images/testtrip.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TripDetailsScreen(
                          userName: 'User 2',
                          tripTitle: 'Title',
                          tripDescription: 'Descrpitoin',
                          tripBudget: '100',
                          tripLocation: 'Riyadh',
                          tripDate: '4/1/2024',
                          tripGovernor: 'user',
                          tripImageUrl: 'lib/assets/images/testtrip.jpg',
                        )),
              );
            },
          ),
          TripContainer(
            userName: 'User 2',
            imageUrl: 'lib/assets/images/testtrip.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TripDetailsScreen(
                          userName: 'User 3',
                          tripTitle: 'Title',
                          tripDescription: 'Descrpitoin',
                          tripBudget: '100',
                          tripLocation: 'Riyadh',
                          tripDate: '4/1/2024',
                          tripGovernor: 'user',
                          tripImageUrl: 'lib/assets/images/testtrip.jpg',
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TripContainer extends StatelessWidget {
  final String userName;
  final String imageUrl;
  final VoidCallback onTap;

  TripContainer({
    required this.userName,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Published by: $userName',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
