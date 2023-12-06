import 'package:flutter/material.dart';

class TripDetailsScreen extends StatelessWidget {
  final String userName;
  final String tripTitle;
  final String tripDescription;
  final String tripBudget;
  final String tripLocation;
  final String tripDate;
  final String tripGovernor;
  final String tripImageUrl;

  TripDetailsScreen({
    required this.userName,
    required this.tripTitle,
    required this.tripDescription,
    required this.tripBudget,
    required this.tripLocation,
    required this.tripDate,
    required this.tripGovernor,
    required this.tripImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        title: Text('Trip Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.grey,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(tripImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Trip Title: $tripTitle',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Description: $tripDescription',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('Budget: $tripBudget'),
                SizedBox(height: 8),
                Text('Location: $tripLocation'),
                SizedBox(height: 8),
                Text('Date: $tripDate'),
                SizedBox(height: 8),
                Text('Governor: $tripGovernor'),
                SizedBox(height: 16),
                Text('Published by: $userName',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[50],
                    minimumSize: Size(double.infinity, 30),
                  ),
                  onPressed: () {},
                  child: Text("Join"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
