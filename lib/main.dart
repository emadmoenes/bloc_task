import 'package:bloc_task/blocs/counter_bloc.dart';
import 'package:bloc_task/blocs/theme_bloc.dart';
import 'package:bloc_task/states/theme_state.dart';
import 'package:bloc_task/views/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BLoC Task',
            theme: state.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            home: CounterPage(),
          );
        },
      ),
    );
  }
}
