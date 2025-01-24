

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_texts.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String buttonText;



  OnboardingModel(
      {required this.title,
        required this.image,
        required this.buttonText,
      }
      );
}

List<OnboardingModel>  sliders = [

  OnboardingModel(
      title: AppTexts.Slider1_Title,
      image: AppImages.slider1,
      buttonText: AppTexts.Slider_Button1,
  ) ,


  OnboardingModel(
      title:AppTexts.Slider2_Title,
      image: AppImages.slider2,
      buttonText:AppTexts.Slider_Button1,
  ) ,

  OnboardingModel(
      title: AppTexts.Slider3_Title,
      image: AppImages.slider3,
      buttonText: AppTexts.Slider_Button2,
  ),
];
