import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/gridview_product.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_texts.dart';
import '../home_screen.dart';
import 'gridview_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    // تحديد مرونة Expanded بناءً على ارتفاع الجهاز
    double deviceHeight = MediaQuery.of(context).size.height;
    int expandedFlex,  expandedFlex2 ,height, height2 ;

    if (deviceHeight > 1400) {

      expandedFlex = 6;
      expandedFlex2 = 4;
      height = 270;
      height2 = 20;

    } else if (deviceHeight > 1340) {

      expandedFlex = 6;
      expandedFlex2 = 4;
      height = 150;
      height2 = 20;

    } else  if (deviceHeight > 1000) {

      expandedFlex = 6;
      expandedFlex2 = 4;
      height = 230;
      height2 = 20;

    } else if (deviceHeight > 850) {
      // الأجهزة الكبيرة
      expandedFlex = 5;
      expandedFlex2 = 6;
      height = 120;
      height2 = 20;
    }
    else if (deviceHeight > 750) {
      // الأجهزة المتوسطة
      expandedFlex = 3;
      expandedFlex2 = 4;
      height = 150;
      height2 = 25;
    }
    else if (deviceHeight > 700) {
      // الأجهزة الصغيرة
      expandedFlex = 1;
      expandedFlex2 = 1;
      height = 50;
      height2 = 0;
    }
    else {
      // الأجهزة الصغيرة جدًا
      expandedFlex = 1;
      expandedFlex2 = 1;
      height = 50;
      height2 = 0;
    }

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA  ${deviceHeight}");

    return HomeScreen(
      child2: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: height.h),

           Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppTexts.Categories,
                style: GoogleFonts.almarai(
                  color: AppColors.Categories,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Expanded(
              flex: expandedFlex,
              child: const CategoriesGrid(),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppTexts.buy,
                style: GoogleFonts.almarai(
                  color: AppColors.Categories,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Expanded(
              flex: expandedFlex2,
              child: ProductsGrid(),
            ),
          ],
        ),
      ),

      child: Column(
        children: [
          SizedBox(height: height2.h),

          Center(
            child: Image(
              image: const AssetImage(AppImages.AppLogo),
              height: MediaQuery.sizeOf(context).height * 0.13,
              width: MediaQuery.sizeOf(context).height * 0.13,
            ),
          ),
        ],
      ),
    );
  }
}

