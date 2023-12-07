import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:capstone_1/blocs/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchRequestEvent>((event, emit) {
      print('======= Welcome to BLoC=========');
      emit(LoadingState());
    });
  }
}
