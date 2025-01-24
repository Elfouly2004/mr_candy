import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/utils/app_colors.dart';


class ButtonShare extends StatelessWidget {
  const ButtonShare({super.key, this.onTap, required this.data});
final void Function()? onTap;
final String data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 174,
          height: 50,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.Buttongradient4,
                AppColors.Buttongradient3,
                AppColors.Buttongradient1,
                AppColors.Buttongradient2,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
            data,
              style:GoogleFonts.almarai(
            textStyle: const TextStyle(
            color: AppColors.white, // استخدم لون مخصص من AppColors
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
            ),
          ),
        ),
      ),
    );
  }
}
