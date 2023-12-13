import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_event.dart';
import 'package:capstone_1/blocs/edit_profile_bloc/edit_profile_state.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) {
      if (event.name.isNotEmpty &&
          event.email.isNotEmpty &&
          event.phone.isNotEmpty &&
          event.age.isNotEmpty &&
          event.password.isNotEmpty) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(event.email)) {
          currentUser!.name = 'AMAM';
          currentUser!.age = 27;
          print('====== TEST ======');
          print(currentUser!.name);
          print(currentUser!.age);
        }
      } else {
        emit(EmptyState(message: 'All fileds are required'));
      }
    });
  }
}


// if (RegExp(
              //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              // .hasMatch(event.email))