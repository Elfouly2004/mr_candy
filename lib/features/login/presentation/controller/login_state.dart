part of 'login_cubit.dart';

@immutable
sealed class LoginState {}
final class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState{ }
class LoginSuccessState extends LoginState{ }
class LoginHidepassState extends LoginState{ }
class LogincheckboxState extends LoginState{ }
class LoginFailureState extends LoginState{
  final String errorMessage;LoginFailureState({required this.errorMessage});}
class LoginGoogleFailureState extends LoginState
{final String errorMessage;LoginGoogleFailureState({required this.errorMessage});}
