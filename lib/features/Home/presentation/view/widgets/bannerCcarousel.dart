import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../data/model/banners_model.dart';
import '../../controller/get_banners/get_banners_cubit.dart';
import '../../controller/get_banners/get_banners_state.dart';


class BannerCarousel extends StatelessWidget {
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
                : CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        image: DecorationImage(
                          image: NetworkImage(banner.urlImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.black54,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            banner.category,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return Center(child: Text("Unknown state"));
        },
      ),
    );
  }
}
