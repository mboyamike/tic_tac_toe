import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/repositories.dart';

part 'authentication_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  Stream<User?> build() {
    final repository = ref.watch(repositoryProvider);
    return repository.userStream();
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final repository = ref.read(repositoryProvider);
    await repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInAsGuest() async {
    final repository = ref.read(repositoryProvider);
    await repository.signInAsGuest();
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final repository = ref.read(repositoryProvider);
    await repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
