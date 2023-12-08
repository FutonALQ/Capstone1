import 'package:capstone_1/models/trip.dart';
import 'package:flutter/material.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({
    super.key,
    required this.trip,
  });
  final Trip trip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        title: const Text('Trip Details'),
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
                      image: AssetImage(trip.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Trip Title: ${trip.title}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Description: ${trip.description}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text('Budget: ${trip.cost}'),
                const SizedBox(height: 8),
                Text('Location: ${trip.location}'),
                const SizedBox(height: 8),
                Text('Date: ${trip.date}'),
                const SizedBox(height: 8),
                // Text('Governor: $tripGovernor'),
                const SizedBox(height: 16),
                Text('Published by: ${trip.tripCreator}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[50],
                    minimumSize: const Size(double.infinity, 30),
                  ),
                  onPressed: () {},
                  child: const Text("Join"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
