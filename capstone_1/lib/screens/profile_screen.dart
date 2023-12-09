import 'package:capstone_1/screens/edit_profile_screen.dart';
import 'package:capstone_1/screens/followers_screen.dart';
import 'package:capstone_1/screens/signin_screen.dart';
import 'package:capstone_1/widgets/following_button.dart';
import 'package:capstone_1/widgets/profile_popup_menu.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:capstone_1/widgets/user_info.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile',
              style: TextStyle(
                  color: Color(0xff023047), fontWeight: FontWeight.bold)),
          actions: [
            ProfilePopUpMenu(
              editProfile: PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profile'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()));
                },
              ),
              signout: PopupMenuItem(
                child: const ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninScreen()),
                      (route) => false);
                },
              ),
              mode: PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Mode'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                onTap: () {},
              ),
              language: PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: const Row(
                    children: [
                      Text('EN | '),
                      Text(
                        'عربي',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        UserAvatar(
                          src:
                              'https://www.newarab.com/sites/default/files/styles/image_1440x810/public/2022-10/GettyImages-1243553139.jpg',
                        ),
                        const VerticalDivider(),
                        UserInfo(
                          age: '24',
                          city: 'Dammam',
                          name: 'Abdullah Mubarak',
                          phone: '0544537726',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FollowingButton(
                          text: 'Following',
                          noOfusers: 100,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FollowersScreen(isFollowing: true)));
                          },
                        ),
                        const SizedBox(width: 8),
                        FollowingButton(
                          text: 'Followers',
                          noOfusers: 100,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FollowersScreen(isFollowing: false)));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const ProfileTaps(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTaps extends StatelessWidget {
  const ProfileTaps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'My Trips',
              ),
              Tab(
                text: 'Joint Trips',
              ),
            ],
          ),
          Flexible(
            child: TabBarView(
              children: [
                ListView(
                  children: const [
                    Text('Meow Meow'),
                  ],
                ),
                ListView(
                  children: const [
                    Text('Bsbsbsbs'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
