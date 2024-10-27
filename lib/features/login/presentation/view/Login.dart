import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:mrcandy/features/Home/presentation/view/home.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../shared_widgets/Button_share.dart';
import '../../../../shared_widgets/Custom _textform field.dart';
import '../../../../shared_widgets/custom_appbar.dart';
import '../../../../shared_widgets/rich_text.dart';
import '../../../Greate_account/presentation/view/greate acoount.dart';
import '../controller/login_cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else if (state is LoginFailureState) {
            IconSnackBar.show(
               context,
              snackBarType: SnackBarType.alert,
              label:state.errorMessage,
              labelTextStyle: TextStyle(fontWeight: FontWeight.bold),
              backgroundColor:  AppColors.Appbar2,
              iconColor: Colors.white,
              maxLines: 2,


            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingState,
            progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.Appbar1),
            ),
            child: Custom_Appbar(
               topLeft: Radius.circular(40.0) ,
              topRight: Radius.circular(40.0) ,
              height: MediaQuery.of(context).size.height * 0.8,
              widget: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CustomTextformfeild(
                      keyboardType: TextInputType.emailAddress,
                      controller: BlocProvider.of<LoginCubit>(context).Email,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 30,
                            child: VerticalDivider(
                              color: AppColors.Textformfeild,
                              thickness: 1.5,
                              width: 10,
                              indent: 1,
                              endIndent: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.email_outlined,
                              color: AppColors.Textformfeild,
                            ),
                          ),
                        ],
                      ),
                      hintText: "    ادخل البريد الالكتروني",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    CustomTextformfeild(
                      keyboardType: TextInputType.visiblePassword,
                      controller: BlocProvider.of<LoginCubit>(context).password,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 30,
                            child: VerticalDivider(
                              color: AppColors.Textformfeild,
                              thickness: 1.5,
                              width: 10,
                              indent: 1,
                              endIndent: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.lock_outlined,
                              color: AppColors.Textformfeild,
                            ),
                          ),
                        ],
                      ),
                      hintText: " ادخل كلمة المرور",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    ButtonShare(
                      data: "تسجيل الدخول",
                      onTap: () {
                        BlocProvider.of<LoginCubit>(context).login();
                      },
                    ),
                    Rich_Text(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Greate_acoount()));
                      },
                      text1: AppTexts.No_account,
                      text2: AppTexts.signup_login,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
