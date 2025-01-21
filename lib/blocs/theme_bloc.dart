import 'package:bloc_task/events/theme_event.dart';
import 'package:bloc_task/states/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(false)) {
    on<ThemeEvent>((event, emit) {
      if (event is ToggleTheme) {
        emit(ThemeState(!state.isDarkTheme));
      }
    });
  }
}
