abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  String imageUrl;
  String name;
  // String email;
  String phone;
  String age;
  // String password;
  String city;

  UpdateProfileEvent(
      {required this.imageUrl,
      required this.name,
      // required this.email,
      required this.phone,
      required this.age,
      // required this.password,
      required this.city});
}
