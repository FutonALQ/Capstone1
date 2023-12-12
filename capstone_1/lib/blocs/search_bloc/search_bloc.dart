import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/blocs/search_bloc/search_state.dart';
import 'package:capstone_1/models/user.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchRequestEvent>((event, emit) async {
      emit(LoadingState());
      final List<UserModel> usersList = await getSearchUser(event.query);
      emit(ResultResponseState(response: usersList));
    });
    on<ClearSearchEvent>((event, emit) async {
      emit(ClearSearchState());
    });

    on<FollowEvent>((event, emit) async {
      final currentUserId = Supabase.instance.client.auth.currentUser!.id;
      final check =
          await isFollowed(currentUserId, event.user.user_uuid.toString());
      if (check == false) {
        await follow(currentUserId, event.user.user_uuid.toString());
        final List<UserModel> usersList = await getSearchUser(event.query);
        emit(FollowState(users: usersList, followState: false));
      } else {
        return;
      }
    });
  }
}
