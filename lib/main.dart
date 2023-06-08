import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_chat/View/Screens/MainScreen/super_main_screen.dart';
import 'package:mohamed_chat/View/Screens/Welcome/welcomeScreen.dart';
import 'package:mohamed_chat/View/Screens/Welcome/welcome_controller.dart';

import 'Data/Cubits/GetUsers/get_users_cubit.dart';
import 'firebase_options.dart';
import 'helpers/CacheHelper.dart';
import 'helpers/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WelcomeController.onReady();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<GetUsersCubit>(
            create: (BuildContext context) => GetUsersCubit(),
          ),
        ],
        child: MaterialApp(
          home:
              //  WelcomeScreen()

              CacheHelper.getBoolFromShared("isLogedin") != true
                  ? WelcomeScreen()
                  : SuperMainScreen(),
        ),
      );
}
