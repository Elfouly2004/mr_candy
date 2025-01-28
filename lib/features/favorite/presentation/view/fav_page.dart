import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_texts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../controller/fav_cubit.dart';
import '../controller/fav_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Custom Appbar as a widget
          SizedBox(
            height: 111.h, // نفس ارتفاع الـ AppBar
            child: const CustomAppbar(title: AppTexts.Fav),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => FavoritesCubit()..fetchFavorites(),
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavoritesFailureState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is FavoritesSuccessState) {
                    final favorites = state.favorites;

                    if (favorites.isEmpty) {
                      return const Center(child: Text("No Favorites Found"));
                    }

                    return ListView.builder(
                      itemCount: favorites.length,
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        final product = favorites[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final screenWidth = constraints.maxWidth;

                              return Stack(
                                children: [
                                  // Background Container
                                  Container(
                                    height: 160.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: AppColors.Appbar2),
                                      color: AppColors.gridproduct,
                                    ),
                                    child: Row(
                                      children: [
                                        // Product Image
                                        Container(
                                          width: screenWidth * 0.3,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              product.image,
                                              height:120.h,
                                              width: 100.w,
                                              fit: BoxFit.fitHeight,

                                              errorBuilder: (context, error, stackTrace) {
                                                return const Icon(Icons.broken_image);
                                              },
                                            ),
                                          ),
                                        ),
                                        // Product Details
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end, // لمحاذاة النصوص إلى اليمين
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [

                                                    GestureDetector(
                                                      onTap: () {
                                                        // BlocProvider.of<FavoritesCubit>(context)
                                                        //     .toggleFavorite(index);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 20.r,
                                                        backgroundColor: AppColors.white,
                                                        child: Icon(
                                                          product.inFavorites ? Icons.favorite : Icons.favorite_border,
                                                          color: AppColors.defaultcolor,
                                                        ),
                                                      ),
                                                    ),


                                                    Text(
                                                      product.name.split(",").join(""),
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),


                                                  ],
                                                ),
                                                const Spacer(),
                                                // Product Price
                                                Text(
                                                  "${product.price} جنيه",
                                                  textDirection: TextDirection.rtl, // لتجنب المشكلات مع النصوص العربية
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.defaultcolor,
                                                  ),
                                                ),

                                                const SizedBox(height: 0),
                                                // Product Discount
                                                // if (product.discount > 0)
                                                //   Text(
                                                //     " % خصم: ${product.discount}",
                                                //     style:  TextStyle(
                                                //       fontSize: 12.sp,
                                                //       fontWeight: FontWeight.w800,
                                                //       color: Colors.red,
                                                //     ),
                                                //   ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Favorite Button
                                  // Positioned(
                                  //   top: 10,
                                  //   right: 10,
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       // BlocProvider.of<FavoritesCubit>(context)
                                  //       //     .toggleFavorite(index); // Assuming a method for toggling favorite
                                  //     },
                                  //     child: CircleAvatar(
                                  //       radius: 20.r,
                                  //       backgroundColor: AppColors.white,
                                  //       child: Icon(
                                  //         product.inFavorites ? Icons.favorite : Icons.favorite_border,
                                  //         color: AppColors.defaultcolor,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text("Something went wrong!"));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
