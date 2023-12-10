import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_state.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetInfoEvent>((event, emit) async {
      emit(LoadingInfoState());
      final user = await getUser();
      emit(GetInfoState(user: user));
    });
  }
}
