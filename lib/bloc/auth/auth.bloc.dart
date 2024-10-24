import 'package:crm_android/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await Future.delayed(Duration(milliseconds: 500));
      // Use the repository to login
      List loginSuccess = await authRepo.login(
        userId: event.userId,
        password: event.password,
      );
      debugPrint('${loginSuccess[0]} login');
      if (loginSuccess[0]) {
        emit(const AuthSuccess('Login Successful!'));
      } else {
        debugPrint('I am in the aut eelse case,${loginSuccess}');

        // debugPrint('${loginSuccess[1]} login failed');
        emit(AuthFailure('${loginSuccess[0]}'));
      }
    } catch (error) {
      debugPrint('eoor ${error.toString()}');
      emit(AuthFailure('An error occurred: $error'));
    }
  }
}
