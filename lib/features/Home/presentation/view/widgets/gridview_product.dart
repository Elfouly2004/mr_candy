import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../controller/get_product/get_product_cubit.dart';
import '../../controller/get_product/get_product_state.dart';

class ProductsGrid extends StatefulWidget {
  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit()..fetchproducts(),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsFailureState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is ProductsSuccessState) {
            final products = state.productList;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true, // يمنع GridView من التمدد بلا حدود
                      physics: const NeverScrollableScrollPhysics(), // تعطيل التمرير داخل GridView
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return  LayoutBuilder(
                          builder: (context, constraints) {

                            return Stack(
                              children: [
                                // Background Container
                                Container(
                                  height: 200.h, // نسبة مئوية من الشاشة
                                  width: 153.w,  // نسبة مئوية من الشاشة
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.white,
                                  ),
                                  child:
                                      Column(
                                        children: [

                                          Container(
                                            height: 155.h,
                                            width: 153.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.gridproduct,
                                            ),
                                            child: Center(
                                              child: Image.network(
                                                product.image,
                                                height: 120.h,
                                                width: 120.w,
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return const Icon(Icons.broken_image);
                                                },
                                              ),
                                            ),
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Add Button
                                              Container(
                                                height:20.h,
                                                width: 20.w,
                                                decoration: BoxDecoration(
                                                  color: AppColors.defaultcolor,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              // Product Details
                                              Column(
                                                children: [
                                                  Text(
                                                    product.name.split(" ").join("\n"),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "  ${product.price}  جنيه",
                                                    textDirection: TextDirection.rtl, // لتجنب المشكلات مع النصوص العربية

                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.defaultcolor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),



                                ),


                                // Favorite Button
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          width: 30.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.title,
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Text(" -${product.discount}%" ,
                                            style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w500,
                                              fontSize: 10

                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              BlocProvider.of<ProductsCubit>(context).addFavorite(context, index);
                                              BlocProvider.of<ProductsCubit>(context).productList[index].inFavorites =
                                              !BlocProvider.of<ProductsCubit>(context).productList[index].inFavorites;


                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 20.r,
                                            backgroundColor: AppColors.white,
                                            child: Icon(
                                              BlocProvider.of<ProductsCubit>(context).productList[index].inFavorites
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: AppColors.defaultcolor,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ),
                              ],
                            );
                          },
                        );

                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
