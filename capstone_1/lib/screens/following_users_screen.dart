import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';

import 'package:capstone_1/screens/users_profile_screen.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingUsersScreen extends StatelessWidget {
  const FollowingUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetFollowingEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
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
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingFollowingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmptyFollowingState) {
              return const Center(child: Text('You have no following'));
            } else if (state is GetFollowingState) {
              return Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.followingUsers.length,
                  itemBuilder: (context, i) {
                    return UsersCard(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contsex) => UsersProfileScreen(
                                    user: state.followingUsers[i])));
                      },
                      user: state.followingUsers[i],
                      buttonText: 'Unfollow',
                      followOnPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(UnFollowEvent(user: state.followingUsers[i]));
                      },
                    
                    );
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01);
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
