import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/login/presentation/view/Login.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../shared_widgets/Button_share.dart';
import '../../../../shared_widgets/Custom _textform field.dart';
import '../../../../shared_widgets/custom_appbar.dart';
import '../../../../shared_widgets/rich_text.dart';
import '../controller/greate_account_cubit.dart';

class  Greate_acoount extends StatelessWidget {
  const Greate_acoount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      body: Custom_Appbar(
        height: MediaQuery.of(context).size.height * 0.8,
        widget: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [



              BlocBuilder<GreateAccountCubit, GreateAccountState>(
                builder: (context, state)
                {
                return  Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.Textformfeild,width: 2),

                      ),
                      child: BlocProvider.of<GreateAccountCubit>(context).myPhoto==null?
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<GreateAccountCubit>(context).choosephoto();
                        },
                          icon: Icon(Icons.add_a_photo,color: AppColors.Textformfeild,))

                          : ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.file(
                            File( BlocProvider.of<GreateAccountCubit>(context) .myPhoto!.path),
                            fit: BoxFit.cover,)
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      AppTexts.choosephoto,
                      style: GoogleFonts.almarai(
                        color: AppColors.defaultcolor,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                );
              },),


              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              CustomTextformfeild(
                keyboardType: TextInputType.emailAddress,
                controller: BlocProvider.of<GreateAccountCubit>(context).Email,
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
                        Icons.person,
                        color: AppColors.Textformfeild,
                      ),
                    ),
                  ],
                ),

                hintText: "    ادخل الاسم ",
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              CustomTextformfeild(
                keyboardType: TextInputType.emailAddress,
                controller: BlocProvider.of<GreateAccountCubit>(context).password,
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

                hintText: " ادخل البريد الالكنروني",
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              CustomTextformfeild(
                keyboardType: TextInputType.emailAddress,
                controller: BlocProvider.of<GreateAccountCubit>(context).password,
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
                        CupertinoIcons.phone,
                        color: AppColors.Textformfeild,
                      ),
                    ),
                  ],
                ),

                hintText: " ادخل رقم الهاتف ",
              ),


              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              CustomTextformfeild(
                keyboardType: TextInputType.emailAddress,
                controller: BlocProvider.of<GreateAccountCubit>(context).password,
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              ButtonShare(
                data: "انشاء الحساب ",
                onTap: () {

                },),

              Rich_Text(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Login(),));
                },
                text1: AppTexts.yes_account,
                text2: AppTexts.login,

              ),

            ],
          ),
        ),
      ),

    );
  }
}
