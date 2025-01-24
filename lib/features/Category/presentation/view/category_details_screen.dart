import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/features/Category/presentation/view/widgets/cystom_txt.dart';
import 'package:mrcandy/features/Home/data/model/product_model.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const CategoryDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h), // ارتفاع الـ AppBar
        child: CustomAppbar(
          title: "تفاصيل المنتج",
          leading: IconButton(onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.white,size: 30.r,)),
        ),
      ),

       backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [





           const SizedBox(height: 20,),

            Center(
              child: SizedBox(
                height: 200.h, // ارتفاع الصور
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // لتكون الحركة أفقية
                  itemCount: product.images.length, // عدد الصور في القائمة
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w), // مسافة بين الصور
                      child: Container(
                        height:150.h ,
                        width: 250.w,
                        decoration: const BoxDecoration(

                        ),
                        child: Image.network(
                          product.images[index],

                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image, size: 50);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),




            const SizedBox(height: 20),

            const Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),

            CystomTxt(
              data:product.name ,
              fontSize:18,
              color: Colors.black,

            ),



            const SizedBox(height: 20),

            CystomTxt(
              data:"${AppTexts.price} : ${product.price}  جنيه ",
              fontSize:18,
              color: Colors.green,

            ),



            const SizedBox(height: 10),



            CystomTxt(
              data:"${AppTexts.discoundt} : ${product.discount}  % ",
              fontSize:15,
              color: Colors.red,

            ),

            //
            // Divider(
            //   color: Colors.grey,            //   thickness: 1.0,
            //   indent: 16.0,
            //   endIndent: 16.0,
            // ),
            const SizedBox(height: 10),

            Text(
              product.description.split(".")[0], // يقطع النص عند أول نقطة
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),


            const Spacer(),

            Center(
              child: CustomButton(
                onTap: () {

              },
                text: AppTexts.Addcart,


              ),
            ),


           const SizedBox(height: 30,)

          ],
        ),
      ),
    );
  }
}
