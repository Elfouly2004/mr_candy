part of 'greate_account_cubit.dart';

@immutable
sealed class GreateAccountState {}

final class GreateAccountInitial extends GreateAccountState {}
class GreateAccountLoadingState extends GreateAccountState{ }
class GreateAccountSuccessState extends GreateAccountState{ }
class GreateAccountFailureState extends GreateAccountState{

  final String errorMessage;GreateAccountFailureState({required this.errorMessage});
}
