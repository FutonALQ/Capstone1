import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/screens/users_profile_screen.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersUsersScreen extends StatelessWidget {
  const FollowersUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetFollowersEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff8ECAE6),
        title: const Text('Followers'),
        leading: IconButton(
          onPressed: () {
            context.read<ProfileBloc>().add(GetInfoEvent());
            Navigator.pop(context);
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
                return const Center(child: CircularProgressIndicator());
              } else if (state is EmptyFollowersState) {
                return const Center(child: Text('You have no followers'));
              } else if (state is GetFollowersState) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.followersUsers.length,
                  itemBuilder: (context, i) {
                    return UsersCard(
                      onTap: () {},
                      user: state.followersUsers[i],
                      buttonTextColor: const Color(0xff219EBC),
                      followOnPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(FollowEvent(user: state.followersUsers[i]));
                      },
                    );
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
                    return UsersCard(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contsex) => UsersProfileScreen(
                                    user: state.followersUsers[i])));
                      },
                      user: state.followersUsers[i],
                      buttonText: state.check == false ? 'Followed' : 'Follow',
                      followOnPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(FollowEvent(user: state.followersUsers[i]));
                      },
                    );
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
