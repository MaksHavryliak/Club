
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club/repository/auth_repository.dart'; // Переконайтеся, що шлях правильний

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading());

    try {
      await _authRepository.signIn(email: email, password: password);
      emit(const AuthSignedIn());
    } on AuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthFailure(message: "Користувача з такою електронною адресою не знайдено."));
      } else if (e.code == 'wrong-password') {
        emit(const AuthFailure(message: "Неправильний пароль для цього користувача."));
      } else {
        emit(AuthFailure(message: "Помилка: ${e.code}"));
      }
    } catch (e) {
      emit(const AuthFailure(message: "Сталася помилка."));
    }
  }

  Future<void> signUp({required String email, required String username, required String password}) async {
    emit(const AuthLoading());

    try {
      await _authRepository.signUp(email: email, username: username, password: password);
      emit(const AuthSignedUp());
    } on AuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthFailure(message: 'Вказаний пароль занадто слабкий.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthFailure(message: 'Акаунт з такою електронною адресою вже існує.'));
      } else {
        emit(AuthFailure(message: "Помилка: ${e.code}"));
      }
    } catch (e) {
      emit(const AuthFailure(message: "Сталася помилка."));
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      emit(const AuthInitial());
    } catch (e) {
      emit(const AuthFailure(message: "Сталася помилка під час виходу."));
    }
  }
}