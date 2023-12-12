import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/screens/followers_users_screen.dart';
import 'package:capstone_1/screens/following_users_screen.dart';
import 'package:capstone_1/widgets/following_button.dart';
import 'package:capstone_1/widgets/profile_left_widget.dart';
import 'package:capstone_1/widgets/profile_right_widget.dart';
import 'package:capstone_1/widgets/profile_taps.dart';
import 'package:capstone_1/widgets/user_avtar.dart';
import 'package:capstone_1/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersProfileScreen extends StatelessWidget {
  const UsersProfileScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetUsersInfoEvent(user: user));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile',
              style: TextStyle(
                  color: Color(0xff023047), fontWeight: FontWeight.bold)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
                  if (state is LoadingUsersInfoState) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.26,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else if (state is GetUsersInfoState) {
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
                                              const FollowingUsersScreen()));
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
                                              const FollowersUsersScreen()));
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
                letTabText: user.gender == 'Male' ? 'His' : 'Her',
                leftWidget:
                    ProfileLeftWidget(tripOwnerId: user.user_uuid.toString()),
                rightWidget:
                    ProfileRightWidget(tripOwnerId: user.user_uuid.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
