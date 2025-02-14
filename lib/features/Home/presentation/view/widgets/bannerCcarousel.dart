import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../data/model/banners_model.dart';
import '../../controller/get_banners/get_banners_cubit.dart';
import '../../controller/get_banners/get_banners_state.dart';

class BannerCarousel extends StatefulWidget {
  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannersCubit()..fetchBanners(),
      child: BlocBuilder<BannersCubit, BannersStates>(
        builder: (context, state) {
          if (state is BannersLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BannersFailureState) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          } else if (state is BannersSuccessState) {
            final banners = BannersCubit.get(context).banners;
            return banners.isEmpty
                ? Center(child: Text("No banners available"))
                : Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180.h,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: banners.map((banner) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 300.w,
                          height:100.h,
                          margin: const  EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                            image: DecorationImage(
                              image: NetworkImage(banner.urlImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 15.h),

                AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: banners.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    activeDotColor: AppColors.Appbar2,
                    dotColor: Colors.grey,
                  ),
                ),
              ],
            );
          }
          return Center(child: Text("Unknown state"));
        },
      ),
    );
  }
}
