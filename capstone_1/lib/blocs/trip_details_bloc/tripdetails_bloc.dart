import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_event.dart';
import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_state.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsState> {
  TripDetailsBloc() : super(TripDetailsInitialState()) {
    on<FetchTripDetailsEvent>((event, emit) async {
      emit(TripDetailsLoadingState());

      try {
        final trip = await getTripDetails(event.tripId);
        emit(TripDetailsSuccessState(trip));
      } catch (error) {
        print('Failed to get trip details: $error');
        emit(TripDetailsErrorState('Failed to get trip details: $error'));
      }
    });

    on<UpdateTripEvent>((event, emit) async {
      try {
        await updateTrip(event.tripId, event.body);
        emit(TripUpdateSuccessState());
      } catch (error) {
        print('Failed to update trip: $error');
        emit(TripDetailsErrorState('Failed to update trip: $error'));
      }
    });
  }
}