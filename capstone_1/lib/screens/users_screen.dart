import 'package:capstone_1/blocs/chat_bloc/chat_bloc.dart';
import 'package:capstone_1/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    context.read<ChatBloc>().add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
          style:
              TextStyle(color: Color(0xff023047), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff8ECAE6),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is GetUsersSuccessedState) {
            return ListView.separated(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  user: state.users[index],
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.users[index].imageUrl ?? "")),
                    title: Text(state.users[index].name ?? ""),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Color(0xff023047),
                );
              },
            );
          } else if (state is ErrorGetUsersState) {
            return const Text("error!!");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
