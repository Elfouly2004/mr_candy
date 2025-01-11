import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/Category/presentation/view/category_screen.dart';
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
    return HomeScreen(

      child: Column(
        children: [

          SizedBox(height: 40.h),

          Center(
            child: Image(
              image: AssetImage(AppImages.AppLogo),
              height: MediaQuery.sizeOf(context).height * 0.13,
              width: MediaQuery.sizeOf(context).height * 0.13,
            ),
          ),


        ],
      ),

      child2: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(height:60.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  AppTexts.Categories,
                  style: TextStyle(
                    color: AppColors.Categories,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),


            Expanded(
                flex:3,
                child: CategoriesGrid()),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  AppTexts.buy,
                  style: TextStyle(
                    color: AppColors.Categories,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            Expanded(
                flex:2,
                child: ProductsGrid()),

          ],),
      ),
    );
  }
}
