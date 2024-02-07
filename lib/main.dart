// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/authentication_provider.dart';
import 'package:tic_tac_toe/main_menu_screen.dart';
import 'package:tic_tac_toe/sign_in_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
  FirebaseDatabase.instance.useDatabaseEmulator('127.0.0.1', 9000);
  

  runApp(const ProviderScope(child: TicTacToeApp()));
}

class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticationProvider);

    return MaterialApp(
      title: 'Tic-Tac-Toe',
      home: switch (user) {
        // ignore: unused_local_variable
        AsyncData(:final value?) => const MainMenuScreen(),
        _ => const SignInScreen(),
      },
    );
  }
}
