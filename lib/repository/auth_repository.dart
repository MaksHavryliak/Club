
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code, message: e.message);
    } catch (e) {
      throw AuthException(code: 'unknown-error', message: 'An unknown error occurred.');
    }
  }

  Future<void> signUp({required String email, required String username, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        "userID": userCredential.user!.uid,
        "userName": username,
        "email": email,
      });
      await userCredential.user!.updateDisplayName(username);
    } on FirebaseAuthException catch (e) {
      throw AuthException(code: e.code, message: e.message);
    } catch (e) {
      throw AuthException(code: 'unknown-error', message: 'An unknown error occurred.');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(code: 'unknown-error', message: 'An unknown error occurred.');
    }
  }
}

class AuthException implements Exception {
  final String code;
  final String? message;

  AuthException({required this.code, this.message});

  @override
  String toString() => 'AuthException(code: $code, message: $message)';
}