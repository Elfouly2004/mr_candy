import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../data/model/user_model.dart';
import '../../data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();

  final LoginRepo loginRepo ;

  Future<void> login()  async{

    emit(LoginLoadingState());
    var result = await loginRepo.login(
      email: Email.text.trim(),
      pass: password.text.trim()
      ,);

    result.fold((left )  {
      emit(LoginFailureState(errorMessage: left.message));
    } , (right) {
      emit(LoginSuccessState(userModel: right));
    });




  }


}
