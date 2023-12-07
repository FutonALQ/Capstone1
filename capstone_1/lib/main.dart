import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/screens/nav_bar.dart';
import 'package:capstone_1/screens/welcome_screen.dart';
import 'package:capstone_1/services/supabase_service.dart';
import 'package:capstone_1/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  supabaseConfig();
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
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        theme: appThemme['light'],
        home: const AppNavigationBar(),
      ),
    );
  }
}



/*
eyJhbGciOiJIUzI1NiIsImtpZCI6IlE1M1VEZGJGTlY4bkNDVGkiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzAxOTI0OTA0LCJpYXQiOjE3MDE5MjEzMDQsImlzcyI6Imh0dHBzOi8vaHh3aWpxaXJtdHF0Y3N6ZXd0eHouc3VwYWJhc2UuY28vYXV0aC92MSIsInN1YiI6ImNjNDgyYjEyLTExMmQtNDIwYS05ZTJmLTk0N2ZjNTZjOWExYSIsImVtYWlsIjoia29kaWxhczQ4N0BneXhtei5jb20iLCJwaG9uZSI6IiIsImFwcF9tZXRhZGF0YSI6eyJwcm92aWRlciI6ImVtYWlsIiwicHJvdmlkZXJzIjpbImVtYWlsIl19LCJ1c2VyX21ldGFkYXRhIjp7fSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJvdHAiLCJ0aW1lc3RhbXAiOjE3MDE5MjEzMDR9XSwic2Vzc2lvbl9pZCI6ImYxYTQwOGIwLWU4MTktNDA1Yy1hYzY0LTFhNzBiNDE1Y2I2ZCJ9.wKn2j3-fykrc_FSZ0cMhjsOXEuoqgDBWAxuCvfOY3Is
*/