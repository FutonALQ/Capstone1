import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/widgets/search_text_field.dart';
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
              // SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              SearchTextField(
                controller: searchController,
                onChange: (query) {
                  context.read<SearchBloc>().add(
                        SearchRequestEvent(query: query),
                      );
                },
                onCancel: () {},
              ),

              // Center(child: CircularProgressIndicator()),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                      // leading: Image.asset('name'),
                      leading: Container(
                        height: 40,
                        width: 40,
                        color: Colors.amber,
                      ),
                      title: const Text('Abdullah'),
                      subtitle: const Text('0548219705'),
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01);
                },
              ),

              // ElevatedButton(
              //   onPressed: () async {
              //     List userList = await getUsers();
              //     print(
              //         '============================\n$userList\n=============================');
              //   },
              //   child: Text('TEST'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
