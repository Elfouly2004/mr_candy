import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Stack(
                  children: [




                Column(
                children: [

                Container(
                height: 156,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.gridproduct,
                  ),
                  child: Center(
                    child: Image.network(
                       height: 100,
                      width: 100,
                      product.image,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image);
                      },
                    ),
                  ),
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [



                Container(
                height: 24,
                width: 23,
                decoration: BoxDecoration(
                color: AppColors.defaultcolor,
                borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                child: Icon(
                Icons.add,
                size: 15,
                color: AppColors.white,
                ),
                ),
                ),


                Column(
                textDirection: TextDirection.rtl,

                children: [
                Text(
                product.name.split(" ").join("\n"),
                style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                ),
                textDirection: TextDirection.rtl,

                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                ),

                Text(
                "  ${product.price}  جنيه",
                style: const TextStyle(

                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.defaultcolor,
                ),
                textDirection: TextDirection.rtl,
                ),
                ],
                )


                ],
                ),


                ],
                ),


                    Positioned(
                      height: 45,
                      left: 145,
                      child: GestureDetector(
                        onTap: ( ) {
                          setState(() {

                            BlocProvider.of<ProductsCubit>(context).productList[index].inFavorites=!BlocProvider.of<ProductsCubit>(context).productList[index].inFavorites;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          child:    Icon(

                            BlocProvider.of<ProductsCubit>(context).productList[index].inFavorites == true?
                            Icons.favorite : Icons.favorite_border,
                            color: AppColors.defaultcolor,
                          ),
                        ),
                      ),
                    ),



                  ],
                );



              },
            );

          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
