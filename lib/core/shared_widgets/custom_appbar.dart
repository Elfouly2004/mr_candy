import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 111.h,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.Appbar1,
                AppColors.Appbar2,
                AppColors.Appbar3,
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.almarai(
            color: AppColors.white,
            fontSize: 20.sp, // حجم الخط
            fontWeight: FontWeight.bold, // سمك الخط
          ),
        ),
        centerTitle: true,

    );
  }
}
