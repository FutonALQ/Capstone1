import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/screens/edit_profile_screen.dart';
import 'package:capstone_1/screens/followers_screen.dart';
import 'package:capstone_1/screens/signin_screen.dart';
import 'package:capstone_1/widgets/following_button.dart';
import 'package:capstone_1/widgets/profile_popup_menu.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:capstone_1/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                  final supabase = Supabase.instance.client;
                  supabase.auth.signOut();
                  currentUser = null;
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
            color: Color(0xff219EBC),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoadingInfoState) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.26,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else if (state is GetInfoState) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              UserAvatar(
                                src: state.user.imageUrl.toString(),
                              ),
                              const VerticalDivider(),
                              UserInfo(
                                age: '${state.user.age.toString()} years',
                                city: state.user.city.toString(),
                                name: state.user.name.toString(),
                                phone: state.user.phone.toString(),
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
                                          builder: (context) => FollowersScreen(
                                              isFollowing: true)));
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
                                          builder: (context) => FollowersScreen(
                                              isFollowing: false)));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView(
                    children: [
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      GridView.builder(
                        padding: const EdgeInsets.only(bottom: 50),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 170 / 272,
                        ),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          'https://e7.pngegg.com/pngimages/550/997/png-clipart-user-icon-foreigners-avatar-child-face.png',
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        'Movie',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        '2023-12-20',
                                        style: TextStyle(
                                          color: Color(0xFF637663),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Text(
                                        '10:00 AM',
                                        style: TextStyle(
                                          color: Color(0xFF637663),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Text(
                                        'Nakheel',
                                        style: TextStyle(
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
                                )),
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.5),
                    ],
                  ),
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
