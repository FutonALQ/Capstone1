abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  String imageUrl;
  String name;
  String phone;
  String age;
  String city;

  UpdateProfileEvent(
      {required this.imageUrl,
      required this.name,
      required this.phone,
      required this.age,
      required this.city});
}
