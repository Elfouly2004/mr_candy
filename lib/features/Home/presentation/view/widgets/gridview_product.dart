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
                  children: [GridView.builder(
                      shrinkWrap: true, // يمنع GridView من التمدد بلا حدود
                      physics: const NeverScrollableScrollPhysics(), // تعطيل التمرير داخل GridView
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return  LayoutBuilder(
                          builder: (context, constraints) {
                            final screenHeight = constraints.maxHeight;
                            final screenWidth = constraints.maxWidth;

                            return Stack(
                              children: [
                                // Background Container
                                Container(
                                  height: 156.h, // نسبة مئوية من الشاشة
                                  width: 180.w,  // نسبة مئوية من الشاشة
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.gridproduct,
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      product.image,
                                      height: 100.h,
                                      width: 100.w,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image);
                                      },
                                    ),
                                  ),
                                ),

                                // Positioned Row for Product Details
                                Positioned(
                                  top: 160.h, // ديناميكي بالنسبة إلى الشاشة
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Add Button
                                      Container(
                                        height: screenHeight * 0.15,
                                        width: screenWidth * 0.15,
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
                                ),

                                // Favorite Button
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Container(
                                          width: MediaQuery.sizeOf(context).width*0.09,
                                          height: MediaQuery.sizeOf(context).height*0.022,
                                          decoration: BoxDecoration(
                                            color: AppColors.title,
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Text(" -${product.discount}%" ,style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w500

                                          ),),
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