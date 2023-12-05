abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignUpEvent(
    this.email,
    this.password,
    this.name,
  );
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(
    this.email,
    this.password,
  );
}

class OTPEvent extends AuthEvent {
  final String otp;
  final String email;
  OTPEvent(this.otp, this.email);
}
