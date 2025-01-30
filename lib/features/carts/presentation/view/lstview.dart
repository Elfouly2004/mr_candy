
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../controller/carts_cubit.dart';
import 'Richtxt.dart';

class Lstview extends StatelessWidget {
  const Lstview({super.key, this.itemCount, this.cartitems});
//cartItems.length,
  //cartItems[index];
  final int? itemCount;
  final dynamic cartitems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.all(15.0),
      itemBuilder: (context, index) {
        final item = cartitems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 175.h,
            width: 330.w,
            decoration: BoxDecoration(
              color: AppColors.gridproduct,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Stack(
              children: [
                // Remove button
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<CartsCubit>(context).deleteCart(context, index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          bottomRight: Radius.circular(25.r),
                          bottomLeft: Radius.circular(2.r),
                        ),
                      ),

                      child: Text(
                        "حذف",
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:MainAxisAlignment.start ,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          imageUrl: item.product.image,
                          height: 100.h,
                          width: 80.w,
                          fit: BoxFit.fitHeight,
                          // placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // عرض مؤشر تحميل أثناء التحميل
                          errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50, color: Colors.red), // عرض أيقونة عند فشل التحميل
                        ),
                      ),


                      SizedBox(width: 15.w),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Product Name
                            Text(
                              item.product.name,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.almarai(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.cartresult
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h),
                            // Quantity and Total Price
                            Richtxt(
                              txt1:AppTexts.Amount ,
                              txt2: "${item.quantity}",
                            ),
                            SizedBox(height: 5.h),

                            Richtxt(
                              txt1:AppTexts.Total ,
                              txt2: "${item.product.price * item.quantity} ج",
                            ),

                          ],
                        ),
                      ),



                    ],
                  ),
                ),

                Positioned(
                  top: 120.h,

                  left: 130,
                  child: Row(

                    children: [

                      GestureDetector(
                        onTap: () {
                          // Decrease quantity logic
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.bottom_g1,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.remove,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),




                      SizedBox(width: 10.w),

                      Text(
                        item.quantity.toString().padLeft(2, "0"),
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      SizedBox(width: 10.w),

                      GestureDetector(
                        onTap: () {
                          // Increase quantity logic
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.Appbar3,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.add,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
