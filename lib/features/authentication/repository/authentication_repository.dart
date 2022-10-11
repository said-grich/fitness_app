import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/features/authentication/models/user_model.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  var currentUser = UserModel.empty;
  AuthenticationRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> singupWithEmailAndPassword(
      {required String email, required String password}) async {
     
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     
      
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
  }

  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(
        id: uid, email: email, fullName: displayName, photo: photoURL);
  }



}
