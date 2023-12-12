import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/screens/chat_screen.dart';
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

// ignore: must_be_immutable
class UsersProfileScreen extends StatelessWidget {
  UsersProfileScreen(
      {super.key,
      required this.user,
      this.direction = '',
      required this.identity});
  final UserModel user;
  String direction;
  UserModel identity;
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetUsersInfoEvent(user: user));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (direction == 'following') {
                print('*****************FOLLOWING********************');
                context
                    .read<ProfileBloc>()
                    .add(GetFollowingEvent(user: identity));
                Navigator.pop(context);
              } else if (direction == 'followers') {
                print('*****************FOLLOWERS********************');
                context
                    .read<ProfileBloc>()
                    .add(GetFollowersEvent(user: identity));
                Navigator.pop(context);
              } else {
                print('*****************NULL********************');
                Navigator.pop(context);
              }
            },
          ),
          title: const Text('Profile',
              style: TextStyle(
                  color: Color(0xff023047), fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contsex) => ChatScreen(user: user)));
              },
              icon: const Icon(
                Icons.chat_bubble,
                color: Colors.blue,
              ),
            ),
          ],
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
                                              FollowingUsersScreen(
                                                  user: state.user,
                                                  dirction: 1)));
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
                                                  dirction: 1)));
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
