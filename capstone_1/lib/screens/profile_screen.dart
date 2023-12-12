import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/screens/edit_profile_screen.dart';
import 'package:capstone_1/screens/followers_users_screen.dart';
import 'package:capstone_1/screens/following_users_screen.dart';
import 'package:capstone_1/screens/form_screen.dart';
import 'package:capstone_1/screens/signin_screen.dart';
import 'package:capstone_1/widgets/following_button.dart';
import 'package:capstone_1/widgets/profile_left_widget.dart';
import 'package:capstone_1/widgets/profile_popup_menu.dart';
import 'package:capstone_1/widgets/profile_right_widget.dart';
import 'package:capstone_1/widgets/profile_taps.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:capstone_1/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetInfoEvent());
    print('TEST');
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TripFormScreen()));
          },
          child: const Icon(
            Icons.add,
            color: Color(0xff219EBC),
          ),
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
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
                                noOfusers: state.followingUsers.length,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FollowingUsersScreen(
                                                  user: state.user,
                                                  dirction: 0)));
                                },
                              ),
                              const SizedBox(width: 8),
                              FollowingButton(
                                text: 'Followers',
                                noOfusers: state.followersUsers.length,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FollowersUsersScreen(
                                                  user: state.user,
                                                  dirction: 0)));
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
              ProfileTaps(
                leftWidget: ProfileLeftWidget(
                    tripOwnerId: Supabase.instance.client.auth.currentUser!.id),
                rightWidget: const ProfileRightWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
