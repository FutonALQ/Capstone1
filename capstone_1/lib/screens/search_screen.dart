import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/blocs/search_bloc/search_state.dart';
import 'package:capstone_1/widgets/search_text_field.dart';
import 'package:capstone_1/widgets/users_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  String aQuery = '';
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
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is ClearSearchState) {
                      SearchTextField(
                        controller: searchController,
                        onChange: (query) {
                          aQuery = query;
                          context
                              .read<SearchBloc>()
                              .add(SearchRequestEvent(query: query));
                        },
                      );
                    }

                    return SearchTextField(
                      controller: searchController,
                      onChange: (query) {
                        aQuery = query;
                        context
                            .read<SearchBloc>()
                            .add(SearchRequestEvent(query: query));
                      },
                    );
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                BlocConsumer<SearchBloc, SearchState>(
                  listener: (context, state) {
                    if (state is LoadingState) {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));
                    }
                  },
                  builder: (context, state) {
                    if (state is ResultResponseState) {
                      Navigator.maybePop(context);
                      return state.response.isNotEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.response.length,
                                itemBuilder: (context, i) {
                                  return UsersCard(
                                    onTap: () {},
                                    user: state.response[i]!,
                                    followOnPressed: () {
                                      context.read<SearchBloc>().add(
                                          FollowEvent(
                                              user: state.response[i],
                                              query: aQuery));
                                    },
                                  );
                                },
                                separatorBuilder: (context, i) {
                                  return SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.01);
                                },
                              ),
                            )
                          : Container();
                    } else if (state is FollowState) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.users.length,
                          itemBuilder: (context, i) {
                            return UsersCard(
                              onTap: () {},
                              user: state.users[i],
                              buttonText: state.followState == false
                                  ? 'Unfollow'
                                  : 'Follow',
                              buttonTextColor: state.followState == false
                                  ? Colors.red
                                  : const Color(0xff023047),
                              followOnPressed: () {
                                context.read<SearchBloc>().add(FollowEvent(
                                    user: state.users[i], query: aQuery));
                              },
                            );
                          },
                          separatorBuilder: (context, i) {
                            return SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.01);
                          },
                        ),
                      );
                    }
                    return const Text("");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
