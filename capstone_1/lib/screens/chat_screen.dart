import 'package:capstone_1/blocs/chat_bloc/chat_bloc.dart';
import 'package:capstone_1/models/chat.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/widgets/chat_widgets.dart';
import 'package:capstone_1/widgets/textfield_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  final UserModel user;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(user.name ?? ""),
      ),
      bottomSheet: ChatTextField(
        controller: messageController,
        toUserId: user.user_uuid!,
      ),
      body: StreamBuilder(
        stream: bloc.getMessages(user.user_uuid!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Chat> messages = snapshot.data!;
            ScrollController scrollController = ScrollController();

            Future.delayed(const Duration(milliseconds: 100 ~/ 60), () {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            });

            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    message: messages[index].message ?? "",
                    isMine: messages[index].isMine ?? true,
                    // createdAt: messages[index].createdAt ?? "",
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
