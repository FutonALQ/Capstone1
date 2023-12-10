part of 'trip_bloc.dart';

abstract class TripEvent {}

class GetUsersEvent extends TripEvent {
  final Trip trip;

  GetUsersEvent(this.trip);
}
