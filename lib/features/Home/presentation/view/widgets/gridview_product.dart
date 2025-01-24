import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../controller/get_product/get_product_cubit.dart';
import '../../controller/get_product/get_product_state.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

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

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,

              child: Wrap(
                spacing: 20.0.w, // Horizontal spacing between items
                runSpacing: 20.0.h, // Vertical spacing between rows
                children: List.generate(
                  products.length,
                      (index) {
                    final product = products[index];
                    return Stack(
                      children: [
                        Container(
                          width: 153.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 155.h,
                                width: 153.w,
                                decoration: const BoxDecoration(
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
                              Text(
                                product.name.split(" ").join(" "),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.end,
                              ),


                            SizedBox(height: 8.h,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<ProductsCubit>(context).addCart(context, index);
                                    },
                                    child: Container(
                                      height: 25.h,
                                      width: 25.w,
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
                                  ),

                                  Text(
                                    "  ${product.price}  جنيه",
                                    textDirection: TextDirection.rtl,
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
                        Positioned(
                          top: 5.h,
                          left: 5.w,

                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  color: AppColors.title,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "-${product.discount}%",
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ),

                              SizedBox(width: 85.w,),

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
                          )

                        ),
                      ],
                    );
                  },
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
