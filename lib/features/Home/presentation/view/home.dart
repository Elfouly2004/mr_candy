import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/bannerCcarousel.dart';
import 'package:mrcandy/shared_widgets/custom_appbar.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../shared_widgets/Custom _textform field.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Custom_Appbar(
        height:  MediaQuery.of(context).size.height * 0.7,
        topLeft: Radius.circular(0) ,
        topRight: Radius.circular(0),
        widget: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),


              BannerCarousel(),


              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          ],
          ),
        ),
      ),


    );
  }
}
