
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../onboarding/peresentation/views/custom_onboarding.dart';



class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override


  void initState() {

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    super.initState();
    Future.delayed(const Duration(
        seconds: 2
    ) , () {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (C) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        return Sliderpage();
      } ));
    }
    );
  }

  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width:double.infinity,
        decoration: BoxDecoration(
         gradient: LinearGradient(
             begin: Alignment.topRight,
             end: Alignment.bottomLeft,
             colors: [
       AppColors.gradient1,
       AppColors.gradient2,

         ]
         )
        ),
        child: Center(
          child: ZoomIn(
            child: Image(
              image: AssetImage(AppImages.AppLogo),
              height:MediaQuery.sizeOf(context).height*0.15,
              width:MediaQuery.sizeOf(context).height*0.15 ,
            ),

          ),
        ),

    );
  }
}