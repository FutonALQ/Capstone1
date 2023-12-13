import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/screens/profile_screen.dart';
import 'package:capstone_1/screens/users_profile_screen.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: must_be_immutable
class FollowersUsersScreen extends StatelessWidget {
  FollowersUsersScreen({super.key, required this.user, required this.dirction});
  UserModel user;
  int dirction;
  final currentUserId = Supabase.instance.client.auth.currentUser!.id;
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetFollowersEvent(user: user));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
            currentUserId == user.user_uuid ? 'My Followers' : 'Followers'),
        leading: IconButton(
          onPressed: () {
            if (dirction == 0) {
              context.read<ProfileBloc>().add(GetInfoEvent());
              Navigator.pop(context);
            } else {
              context.read<ProfileBloc>().add(GetUsersInfoEvent(user: user));
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is LoadingFollowersState) {
                return const Center(child: CircularProgressIndicator(color: Color(0xff023047)));
              } else if (state is EmptyFollowersState) {
                return const Center(child: Text('You have no followers'));
              } else if (state is GetFollowersState) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.followersUsers.length,
                  itemBuilder: (context, i) {
                    if (state.followersUsers[i].user_uuid == currentUserId) {
                      return UsersCard(
                        isVisible: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contsex) => UsersProfileScreen(
                                        user: state.followersUsers[i],
                                        direction: 'followers',
                                        identity: state.followersUsers[i],
                                      )));
                        },
                        user: state.followersUsers[i],
                        buttonTextColor: const Color(0xff219EBC),
                        followOnPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(FollowEvent(user: state.followersUsers[i]));
                        },
                      );
                    } else {
                      return UsersCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contsex) => UsersProfileScreen(
                                        user: state.followersUsers[i],
                                        direction: 'followers',
                                        identity: state.followersUsers[i],
                                      )));
                        },
                        user: state.followersUsers[i],
                        buttonTextColor: const Color(0xff219EBC),
                        followOnPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(FollowEvent(user: state.followersUsers[i]));
                        },
                      );
                    }
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01);
                  },
                );
              } else if (state is UpdateFollowersState) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.followersUsers.length,
                  itemBuilder: (context, i) {
                    if (state.followersUsers[i].user_uuid == currentUserId) {
                      return UsersCard(
                        isVisible: false,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contsex) => const ProfileScreen()));
                        },
                        user: state.followersUsers[i],
                        buttonText:
                            state.check == false ? 'Unfollow' : 'Follow',
                        buttonTextColor: state.check == false
                            ? Colors.red
                            : const Color(0xff023047),
                        followOnPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(FollowEvent(user: state.followersUsers[i]));
                        },
                      );
                    } else {
                      return UsersCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contsex) => UsersProfileScreen(
                                      user: state.followersUsers[i],
                                      identity: state.followersUsers[i])));
                        },
                        user: state.followersUsers[i],
                        buttonText:
                            state.check == false ? 'Unfollow' : 'Follow',
                        buttonTextColor: state.check == false
                            ? Colors.red
                            : const Color(0xff023047),
                        followOnPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(FollowEvent(user: state.followersUsers[i]));
                        },
                      );
                    }
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01);
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
