import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/Category/presentation/controller/catgories%20sections%20%20cubit/catgories_sections%20_cubit.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final ProductModel product;

  CategoryDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [


          SizedBox(
            height: 111.h, // نفس ارتفاع الـ AppBar
            child: CustomAppbar(title: "تفاصيل المنتج",
              leading: IconButton(onPressed: () => Navigator.pop(context), 
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.white,size: 30.r,)),
            ),
          ),


          Center(
            child: Image.network(
              product.image,
              height: 200.h,
              width: 200.w,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 50);
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            textDirection: TextDirection.rtl,

            product.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Text(
            "السعر: ${product.price} جنيه",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "الخصم: ${product.discount}%",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 10),

          Text(
            textDirection: TextDirection.rtl,
            product.description,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),


          CustomButton(
            onTap: () {

          },
            text: AppTexts.Addcart,


          )



        ],
      ),
    );
  }
}
