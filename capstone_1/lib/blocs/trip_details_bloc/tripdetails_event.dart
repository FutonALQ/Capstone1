abstract class TripDetailsEvent {}

class FetchTripDetailsEvent extends TripDetailsEvent {
  final String tripId;

  FetchTripDetailsEvent(this.tripId);
}

class UpdateTripEvent extends TripDetailsEvent {
  final String tripId;
  final Map<String, dynamic> body;

  UpdateTripEvent({required this.tripId, required this.body});
}
