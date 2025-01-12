import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../controller/carts_cubit.dart';
import '../controller/carts_state.dart';

class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch carts after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartsCubit>().fetchCarts();
    });

    return BlocProvider<CartsCubit>(
      create: (context) => CartsCubit(),
      child: Scaffold(
        body: Column(
          children: [
            // Custom Appbar widget
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

                    return ListView.builder(
                      itemCount: cartItems.length,
                      padding: const EdgeInsets.all(15.0),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                // Product Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.network(
                                    item.product.image,
                                    height: 120.h,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                // Product Details
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "\$${item.product.price}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Quantity controls
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    // Increase quantity logic
                                                  },
                                                  icon: Icon(Icons.add, size: 20.sp),
                                                ),
                                                Text(
                                                  "Qty: ${item.quantity}",
                                                  style: GoogleFonts.poppins(fontSize: 14.sp),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    // Decrease quantity logic
                                                  },
                                                  icon: Icon(Icons.remove, size: 20.sp),
                                                ),
                                              ],
                                            ),
                                            // Remove button
                                            IconButton(
                                              onPressed: () {
                                                // Remove item from cart logic
                                              },
                                              icon: Icon(Icons.delete, color: Colors.red, size: 24.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
