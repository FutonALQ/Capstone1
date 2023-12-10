import 'package:capstone_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:capstone_1/blocs/chat_bloc/chat_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_bloc.dart';
import 'package:capstone_1/blocs/profile_bloc/profile_event.dart';
import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/screens/nav_bar.dart';
import 'package:capstone_1/screens/search_screen.dart';
import 'package:capstone_1/screens/signup_screen.dart';
import 'package:capstone_1/screens/welcome_screen.dart';
import 'package:capstone_1/services/supabase_service.dart';
import 'package:capstone_1/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await supabaseConfig();
  await Supabase.instance.client.auth.signOut();
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
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(GetInfoEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appThemme['light'],
        home: WelcomeScreen(),
      ),
    );
  }
}
