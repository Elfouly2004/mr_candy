import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

class CustomTextformfeild extends StatelessWidget {
  CustomTextformfeild({
    required this.keyboardType,
    required this.suffixIcon,
    required this.controller,  this.hintText,
  });

  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: TextStyle(
        color: AppColors.Textformfeild,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.symmetric(horizontal: 50,vertical: 15), // هنا تم إضافة padding لزيادة العرض
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.Textformfeild,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.Textformfeild,
            width: 2.0,
          ),
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
          hintStyle: TextStyle(color: AppColors.Textformfeild)
        // suffixText: suffixText


      ),
    );
  }
}
