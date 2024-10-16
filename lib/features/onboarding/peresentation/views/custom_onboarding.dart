import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/core/utils/app_images.dart';
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../login/presentation/view/Login.dart';
import '../../data/model/slider_model.dart';

class Sliderpage extends StatefulWidget {
  const Sliderpage({super.key});

  @override
  State<Sliderpage> createState() => _SliderpageState();
}

class _SliderpageState extends State<Sliderpage> {
  final _controller = PageController();
  int currentIndex = 0; // لتعقب الصفحة الحالية

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.page!.round(); // تحديث قيمة currentIndex عند تغيير الصفحة
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(AppImages.slider), // مسار الصورة الخلفية
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: sliders.length,
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.09,
                            ),
                            Center(
                              child: Image(
                                image: AssetImage(sliders[index].image),
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Text(
                              sliders[index].title,
                              style: GoogleFonts.almarai(
                                textStyle: TextStyle(
                                  color: AppColors.title, // استخدم لون مخصص من AppColors
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              AppTexts.Slider_des,
                              style: GoogleFonts.almarai(
                                textStyle: TextStyle(
                                  color: AppColors.des, // استخدم لون مخصص من AppColors
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),

                          ],
                        );
                      },
                    ),
                  ),

                  SmoothPageIndicator(
                    controller: _controller,
                    count: sliders.length,
                    effect: ScaleEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      dotColor: Colors.grey,
                      activeDotColor: AppColors.selectDot,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      if (currentIndex == sliders.length - 1) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Login();
                        },));
                      } else {
                        _controller.animateToPage(
                          currentIndex + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Container(
                      width: 164,
                      height: 50,
                      decoration: BoxDecoration(
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
                          sliders[currentIndex].buttonText, // استخدام currentIndex لعرض النص المناسب
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
             height: 100,
            left: 20,
            child: TextButton(
             onPressed: () {

            },
                child: Text("تخطي",style: TextStyle(fontSize: 20,color: AppColors.white),)),
          ),

        ],

      ),
    );
  }
}
