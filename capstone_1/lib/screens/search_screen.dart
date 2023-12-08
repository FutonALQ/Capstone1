import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_event.dart';
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

              /* Testing Button */
              // ElevatedButton(
              //   onPressed: () async {
              //     List userList = await getUsers();
              //     print(
              //         '============================\n$userList\n=============================');
              //   },
              //   child: CircularProgressIndicator(strokeAlign: 0.01),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
