import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/carts/presentation/view/Richtxt.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../controller/carts_cubit.dart';
import '../controller/carts_state.dart';
import 'lstview.dart';

class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartsCubit>(
      create: (context) => CartsCubit()..fetchCarts(),
      child: Scaffold(
        body: Column(
          children: [
            // Custom AppBar widget
            SizedBox(
              height: 111.h,
              child: CustomAppbar(title: AppTexts.bag),
            ),
            Expanded(
              child: BlocBuilder<CartsCubit, CartsState>(
                builder: (context, state) {
                  if (state is CartsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartsFailureState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is CartsSuccessState) {
                    final cartItems = state.cartsList;

                    if (cartItems.isEmpty) {
                      return const Center(child: Text("No items in your cart"));
                    }

                    return Column(
                      children: [
                        // ListView of cart items
                        Expanded(
                          flex:10,
                          child: Lstview(
                            itemCount: cartItems.length,
                            cartitems: cartItems,
                          ),
                        ),

                        // Total and Confirm Section
                        Expanded(
                          flex:2,
                          child: Container(
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(

                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "الإجمالي:",
                                      style: GoogleFonts.cairo(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Appbar3,
                                      ),
                                    ),
                                    Text(
                                      "450 ج", // يمكن حساب الإجمالي ديناميكياً هنا
                                      style: GoogleFonts.cairo(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Appbar3,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                ElevatedButton(
                                  onPressed: () {
                                    // منطق التأكيد
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 30.w,
                                    ),
                                    backgroundColor: AppColors.Appbar3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text(
                                    "تأكيد",
                                    style: GoogleFonts.cairo(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return const Center(child: Text("Something went wrong!"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

