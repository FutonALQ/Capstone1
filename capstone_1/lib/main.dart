import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'cabin'), home: const WelcomeScreen()),
    );
  }
}
