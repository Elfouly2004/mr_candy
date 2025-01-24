
abstract class BannersStates{ }
class BannersInitialState extends BannersStates { }
class BannersLoadingState extends BannersStates { }
class BannersFailureState extends BannersStates {
  final String errorMessage ;
  BannersFailureState({required this.errorMessage}) ;
}
class BannersSuccessState extends BannersStates { }