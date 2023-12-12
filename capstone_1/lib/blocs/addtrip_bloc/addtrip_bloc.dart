import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/services/supabase_request.dart';

part 'addtrip_event.dart';
part 'addtrip_state.dart';

// class AddTripBloc extends Bloc<AddTripEvent, AddTripState> {
//   AddTripBloc() : super(AddTripInitialState()) {
//     on<AddTripEvent>(_onAddTrip);
//     on<AddTripValidationErrorEvent>(_onValidationError);
//   }

//   Future<void> _onAddTrip(
//       AddTripEvent event, Emitter<AddTripState> emit) async {
//     emit(AddTripLoadingState());

//     try {
//       // Validate input fields
//       if (event.trip.title!.isEmpty ||
//           event.trip.date!.isEmpty ||
//           event.trip.time!.isEmpty ||
//           event.trip.location!.isEmpty ||
//           event.trip.category!.isEmpty ||
//           event.trip.description!.isEmpty ||
//           event.trip.cost == null) {
//         emit(AddTripValidationErrorState("Please fill all the text fields."));
//         return;
//       }

//       await addTrip(event.trip.toJson(), event.image);
//       print('Trip added successfully! Enjoy');
//       emit(AddTripSuccessState());
//     } catch (error) {
//       print('Failed to add trip: $error');
//       emit(AddTripErrorState("Something went wrong. Please try again."));
//     }
//   }

//   void _onValidationError(
//       AddTripValidationErrorEvent event, Emitter<AddTripState> emit) {
//     emit(AddTripValidationErrorState(event.errorMessage));
//   }
// }

class AddTripBloc extends Bloc<AddTripEvent, AddTripState> {
  AddTripBloc() : super(AddTripInitialState()) {
    on<AddTripEvent>(_onAddTrip);
  }

  Future<void> _onAddTrip(
      AddTripEvent event, Emitter<AddTripState> emit) async {
    emit(AddTripLoadingState());

    try {
      // print('Trying to add trip: ${event.trip.toJson()}');
      await addTrip(event.trip.toJson(), event.image);
      print('Trip added successfully! Enjoy');
      emit(AddTripSuccessState());
    } catch (error) {
      print('Failed to add trip: $error');
      emit(AddTripErrorState("Something went wrong. Please try again."));
    }
  }
}
