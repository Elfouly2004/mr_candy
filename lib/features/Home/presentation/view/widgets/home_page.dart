import 'package:flutter/material.dart';

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

          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

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

            SizedBox(height: MediaQuery.of(context).size.height * 0.19),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppTexts.Categories,
                  style: TextStyle(
                    color: AppColors.Categories,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            Expanded(child: CategoriesGrid()),

          ],),
      ),
    );
  }
}