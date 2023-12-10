import 'package:capstone_1/models/user.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingInfoState extends ProfileState {}

class GetInfoState extends ProfileState {
  UserModel user;
  GetInfoState({required this.user});
}

class LoadingTripsState extends ProfileState {}
