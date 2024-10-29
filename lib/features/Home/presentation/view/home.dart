import 'package:flutter/material.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/gridview_categories.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/home_screen.dart';
import '../../../../core/utils/app_images.dart';
import 'package:mrcandy/core/utils/app_texts.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: HomeScreen(


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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height * 0.17),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppTexts.Categories,
                    style: TextStyle(
                      color: AppColors.Categories,
                      fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  ),
                ],
              ),

              CategoriesGrid(),

          ],),
        ),
      ),


    );
  }
}
