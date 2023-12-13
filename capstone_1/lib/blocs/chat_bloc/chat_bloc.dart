import 'package:bloc/bloc.dart';
import 'package:capstone_1/models/chat.dart';
import 'package:capstone_1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    print("ChatBloc initialized");
    on<GetUsersEvent>(getUsers);
    on<SendMessageEvent>(sendMessage);
  }
  final supabase = Supabase.instance.client;

  String get getCurrentUserId => supabase.auth.currentUser!.id;

  getUsers(GetUsersEvent event, Emitter<ChatState> emit) async {
    try {
      final List allUsers = await supabase
          .from("users")
          .select()
          .neq("user_uuid", getCurrentUserId);
      print("All Users: $allUsers");

      // final List<UserModel> users =
      //     allUsers.map((user) => UserModel.fromJson(user)).toList();
      //     print("Parsed User: $users");
      final List<UserModel> users = allUsers.map((user) {
        final userModel = UserModel.fromJson(user);
        // print("Parsed User: $userModel");
        return userModel;
      }).toList();

      emit(GetUsersSuccessedState(users));
    } catch (e) {
      print(e);
      emit(ErrorGetUsersState());
    }
  }

  sendMessage(SendMessageEvent event, emit) async {
    try {
      final Chat message = Chat(
          message: event.message,
          fromUser: getCurrentUserId,
          toUser: event.toUserId);
      await supabase.from("chat").insert(message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream getMessages(String toUserId) {
    try {
      final allMesaages = supabase
          .from("chat")
          .stream(primaryKey: ['id'])
          .order('created_at', ascending: true)
          .map((items) => items.where((element) =>
              element["from_user"] == getCurrentUserId &&
                  element["to_user"] == toUserId ||
              element["from_user"] == toUserId &&
                  element["to_user"] == getCurrentUserId));

      final messages = allMesaages.map((items) =>
          items.map((item) => Chat.fromJson(item, getCurrentUserId)).toList());
      print("i sm here ---------");
      return messages;
    } catch (error) {
      print(error);
      throw FormatException("Ffff");
    }
  }
}
