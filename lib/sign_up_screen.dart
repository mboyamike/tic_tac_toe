import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/authentication_provider.dart';
import 'package:tic_tac_toe/sign_in_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Email'),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    RegExp emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    bool isValidEmail = emailRegExp.hasMatch(value ?? '');
                    if (isValidEmail) {
                      return null;
                    } else {
                      return 'Please enter a valid email address';
                    }
                  },
                ),
                const SizedBox(height: 32),
                const Text('Password'),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                const Text('Confirm Password'),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == passwordController.text) {
                      return null;
                    }

                    return 'Please make sure your password and confirmed passwords match';
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        bool isValid =
                            formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          return;
                        }

                        final authNotifier =
                            ref.read(authenticationProvider.notifier);
                        authNotifier.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                      child: const Text('Sign Up With Email and password'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final authNotifier =
                            ref.read(authenticationProvider.notifier);
                        authNotifier.signInAsGuest();
                      },
                      child: const Text('Sign in as guest'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
