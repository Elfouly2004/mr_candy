import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();


  GlobalKey<FormState> Username= GlobalKey <FormState>();
  GlobalKey<FormState> Password= GlobalKey <FormState>();



}
