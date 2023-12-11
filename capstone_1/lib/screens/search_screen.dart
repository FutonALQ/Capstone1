import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/widgets/search_text_field.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                SearchTextField(
                  controller: searchController,
                  onChange: (query) {
                    context
                        .read<SearchBloc>()
                        .add(SearchRequestEvent(query: query));
                  },
                  onCancel: () {
                    context.read<SearchBloc>().add(ClearSearchEvent());
                  },
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                // Center(child: CircularProgressIndicator()),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return UsersCard(
                      onTap: () {},
                      user: currentUser!,
                      chatOnPressed: () {},
                      followOnPressed: () {},
                    );
                  },
                  separatorBuilder: (context, i) {
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01);
                  },
                ),

                /* Testing Button */
                ElevatedButton(
                  onPressed: () async {
                    // await follow('42c953d5-cc40-4406-b933-9a643cfe6842',
                    //     'd33d895d-ab10-40b2-90d6-badf3917425b');
                    // await follow('d33d895d-ab10-40b2-90d6-badf3917425b',
                    //     '42c953d5-cc40-4406-b933-9a643cfe6842');
                    // await unfollow('f0785a24-5ca7-4431-acbc-bf6992b516d9');
                    // await isAFollower();
                    // await getOwnerTrips('d33d895d-ab10-40b2-90d6-badf3917425b');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (contsex) => UsersProfileScreen()));
                  },
                  child: const Text('TEST'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
