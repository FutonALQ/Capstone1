import 'package:capstone_1/screens/form_screen.dart';
import 'package:capstone_1/widgets/container_widget.dart';
import 'package:flutter/material.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('lib/assets/images/testtrip.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                'User Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('Phone: 0500320941'),
              Text('Email: user@name.com'),
              Text('City: riyadh'),
              Text('Age: 25'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Followers'),
                      Text('100'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Following'),
                      Text('500'),
                    ],
                  ),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "My Trips",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                buildTripContainer(
                  title: 'By You',
                  onTap: () {
                    _navigateToTripsPage('My Trips');
                  },
                ),
                SizedBox(height: 16),
                buildTripContainer(
                  title: 'By You',
                  onTap: () {
                    _navigateToTripsPage('My Trips');
                  },
                ),
                SizedBox(height: 16),
                buildTripContainer(
                  title: 'By You',
                  onTap: () {
                    _navigateToTripsPage('My Trips');
                  },
                ),
                SizedBox(height: 16),
                Text(
                  "Joining Trips",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ]),
              // SizedBox(height: 16),
              // SizedBox(height: 16),
              buildTripContainer(
                title: 'By user:',
                iconData: Icons.remove_circle_outline,
                onTap: () {
                  _navigateToTripsPage('Joining Trips');
                },
              ),
              SizedBox(height: 16),
              buildTripContainer(
                title: 'By You',
                iconData: Icons.remove_circle_outline,
                onTap: () {
                  _navigateToTripsPage('My Trips');
                },
              ),
              SizedBox(height: 16),
              buildTripContainer(
                title: 'By You',
                iconData: Icons.remove_circle_outline,
                onTap: () {
                  _navigateToTripsPage('My Trips');
                },
              ),
              SizedBox(height: 9),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[50],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripFormScreen(),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToTripsPage(String pageTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripsPage(pageTitle: pageTitle),
      ),
    );
  }
}

class TripsPage extends StatelessWidget {
  final String pageTitle;

  TripsPage({required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Center(
        child: Text('Content of $pageTitle Page'),
      ),
    );
  }
}
