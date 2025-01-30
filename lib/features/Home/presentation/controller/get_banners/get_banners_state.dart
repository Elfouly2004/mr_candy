
import 'package:equatable/equatable.dart';

abstract class BannersStates extends Equatable{
  @override
  List<Object?> get props => [];
}
class BannersInitialState extends BannersStates { }
class BannersLoadingState extends BannersStates { }
class BannersFailureState extends BannersStates {
  final String errorMessage ;
  BannersFailureState({required this.errorMessage}) ;
}
class BannersSuccessState extends BannersStates { }