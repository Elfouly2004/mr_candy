import 'package:flutter/material.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/bannerCcarousel.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/home_screen.dart';
import 'package:mrcandy/shared_widgets/custom_appbar.dart';

import '../../../../core/utils/app_images.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: HomeScreen(
        topLeft: Radius.circular(0) ,
        topRight: Radius.circular(0),
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

        child2: Column(children: [


        ],),
      ),


    );
  }
}
