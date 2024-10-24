part of 'auth.bloc.dart';

@immutable
sealed class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object> get props => [];
}
class LoginButtonPressed extends AuthEvent {
  final String userId;
  final String password;

  const LoginButtonPressed({
    required this.userId,
    required this.password,
  });

  @override
  List<Object> get props => [userId, password];
}