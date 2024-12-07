part of 'greate_account_cubit.dart';

@immutable
sealed class GreateAccountState {}

final class GreateAccountInitial extends GreateAccountState {}
class GreateAccountLoadingState extends GreateAccountState{ }
class GreateAccountSuccessState extends GreateAccountState {
  final UserModelToRegister userModelToRegister;

  GreateAccountSuccessState({required this.userModelToRegister});
}

class GreateAccountphotoSuccess extends GreateAccountState{}
class GreateAccountfinish extends GreateAccountState{}
class GreateAccountFailureState extends GreateAccountState{
  final String errorMessage;GreateAccountFailureState({required this.errorMessage});
}
