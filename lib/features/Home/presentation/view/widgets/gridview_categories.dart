import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrcandy/core/utils/app_colors.dart';

import '../../../../Category/presentation/view/category_screen.dart';
import '../../controller/get_categories/get_categories_cubit.dart';
import '../../controller/get_categories/get_categories_state.dart';

class CategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit()..fetchBanners(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoriesFailureState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is CategoriesSuccessState) {
            final categories = context.read<CategoriesCubit>().categories_lst;

            return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 1.7
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(
                    title: category.name,
                    id: category.id,
                  ),));

                    },
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                         color: Colors.white54,
                      ),
                      child: Center(
                        child: Column(

                          children: [



                            SizedBox(height: 2),

                            Expanded(
                              child: Image.network(
                                category.urlImage,
                                fit: BoxFit.cover,
                              ),
                            ),


                            SizedBox(height: 4),


                            Text(
                              category.name,
                              style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w600,color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
