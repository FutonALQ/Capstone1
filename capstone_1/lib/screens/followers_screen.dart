import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  FollowersScreen({super.key, required this.isFollowing});

  bool isFollowing;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff8ECAE6),
        title: Text(isFollowing ? 'Following' : 'Followers'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, i) {
                  return UsersCard(
                    onTap: () {},
                    src:
                        'https://www.newarab.com/sites/default/files/styles/image_1440x810/public/2022-10/GettyImages-1243553139.jpg',
                    name: 'Abdullah',
                    phone: '0544539726',
                    chatOnPressed: () {},
                    followOnOressed: () {},
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
