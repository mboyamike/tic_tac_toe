import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories.g.dart';

class Repository {
  Repository({required this.firebaseAuth});

  final FirebaseAuth firebaseAuth;

  Stream<User?> userStream() {
    return firebaseAuth.authStateChanges();
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    return firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }
  Future<UserCredential> signInAsGuest()async{
    return firebaseAuth.signInAnonymously();
  }
  Future<void> signOut(){
    return firebaseAuth.signOut();

  }
 
}
 
 @riverpod

   Repository repository(RepositoryRef ref) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Repository(firebaseAuth: firebaseAuth) ;
  }

