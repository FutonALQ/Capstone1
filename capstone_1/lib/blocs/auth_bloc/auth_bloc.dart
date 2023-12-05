import 'package:capstone_1/blocs/auth_bloc/auth_events.dart';
import 'package:capstone_1/blocs/auth_bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  AuthBloc() : super(InitialState()) {
    on<SignUpEvent>((event, emit) async {
      emit(LoadingSignUpState());
      try {
        if (event.email.isNotEmpty &&
            event.name.isNotEmpty &&
            event.password.isNotEmpty) {
          if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(event.email)) {
            // final supabase = Supabase.instance.client;
            // await supabase.auth
            //     .signUp(email: event.email, password: event.password);

            // user = UserModel(
            //     name: event.name, email: event.email, phone: event.phone);

            emit(SuccessSignUpState());
          } else {
            emit(ErrorSignUpState("Please enter correct email"));
          }
        } else {
          emit(ErrorSignUpState("Please enter all fields"));
        }
      } catch (error) {
        print(error.toString());
        emit(ErrorSignUpState("error!"));
      }
    });

    on<OTPEvent>((event, emit) async {
      emit(LoadingOtpState());
      try {
        if (event.otp.isNotEmpty) {
          final supabase = Supabase.instance.client;
          final authResponse = await supabase.auth.verifyOTP(
              token: event.otp, type: OtpType.signup, email: event.email);

          print(Supabase.instance.client.auth.currentUser!.id);
          print(authResponse.user!.id);

          // addUser({
          //   "name": user!.name,
          //   "email": user!.email,
          //   "phone": user!.phone,
          //   "id_auth": authResponse.user!.id
          // });
          emit(SuccessOtpState());
        } else {
          emit(ErrorOtpState("Please enter otp"));
        }
      } catch (e) {
        emit(ErrorOtpState("Error !!"));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(LoadingOtpState());
      try {
        if (event.email.isNotEmpty && event.password.isNotEmpty) {
          final supabase = Supabase.instance.client;
          await supabase.auth
              .signInWithPassword(email: event.email, password: event.password);

          emit(SuccessSignInState());
        } else {
          emit(ErrorSignInState("Please enter all fields"));
        }
      } catch (e) {
        print(e);
        emit(ErrorSignInState("Error !!"));
      }
    });
  }
}
