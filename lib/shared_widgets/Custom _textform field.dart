import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // استيراد Google Fonts

import '../core/utils/app_colors.dart';

class CustomTextformfeild extends StatelessWidget {
  CustomTextformfeild({
    required this.keyboardType,
    required this.suffixIcon,
    required this.controller, this.hintText,
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
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: GoogleFonts.almarai(  // استخدام Google Fonts هنا
        color: AppColors.Textformfeild,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.Textformfeild,
            width: 1.5,
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
        hintStyle: GoogleFonts.almarai(  // استخدام Google Fonts في نمط النص التلميحي
          color: AppColors.Textformfeild,
        ),
      ),
    );
  }
}
