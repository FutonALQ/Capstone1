import 'package:capstone_1/models/user.dart';

abstract class ProfileEvent {}

class GetInfoEvent extends ProfileEvent {}

class GetFollowingEvent extends ProfileEvent {}

class GetFollowersEvent extends ProfileEvent {}

class FollowEvent extends ProfileEvent {
  UserModel user;
  // bool isFollower;
  FollowEvent({required this.user});
}

class UnFollowEvent extends ProfileEvent {
  UserModel user;
  UnFollowEvent({required this.user});
}

class GetUsersInfoEvent extends ProfileEvent {
  UserModel user;
  GetUsersInfoEvent({required this.user});
}
