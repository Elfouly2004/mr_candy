part of 'greate_account_cubit.dart';

@immutable
sealed class GreateAccountState {}

final class GreateAccountInitial extends GreateAccountState {}
class GreateAccountLoadingState extends GreateAccountState{ }
class GreateAccountSuccessState extends GreateAccountState{ }
class GreateAccountGoogleState extends GreateAccountState{ }
class GreateAccountcheckboxState extends GreateAccountState{ }
class GreateAccountFinishState extends GreateAccountState{ }
class GreateAccountFailureState extends GreateAccountState{

  final String errorMessage;GreateAccountFailureState({required this.errorMessage});

}class GreateAccountGoogleFailureState extends GreateAccountState{

  final String errorMessage;GreateAccountGoogleFailureState({required this.errorMessage});

}
