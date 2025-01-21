import 'package:bloc_task/blocs/counter_bloc.dart';
import 'package:bloc_task/blocs/theme_bloc.dart';
import 'package:bloc_task/events/counter_event.dart';
import 'package:bloc_task/events/theme_event.dart';
import 'package:bloc_task/states/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().state.isDarkTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Task',
            style: TextStyle(color: isDark ? Colors.black : Colors.white)),
        backgroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeBloc>().state.isDarkTheme
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: isDark ? Colors.black : Colors.white,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),

      // consumer is used to listen to the state changes of the bloc
      body: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.counter == 5) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Counter is at spacified value 5'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ));
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter: ${state.counter}',
                    style: TextStyle(fontSize: 30)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (state.counter == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Counter cannot be negative'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.deepOrange,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          context.read<CounterBloc>().add(DecrementEvent());
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 30,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          isDark ? Colors.white : Colors.black,
                        ),
                        shape: WidgetStateProperty.all(
                          CircleBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    IconButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(IncrementEvent());
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                        size: 30,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          isDark ? Colors.white : Colors.black,
                        ),
                        shape: WidgetStateProperty.all(
                          CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
