import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Appbar as a widget
          SizedBox(
            height: 111.h, // نفس ارتفاع الـ AppBar
            child: CustomAppbar(title: AppTexts.bag),
          ),
          Expanded(
            child: Center(

            ),
          ),
        ],
      ),
    );
  }
}
