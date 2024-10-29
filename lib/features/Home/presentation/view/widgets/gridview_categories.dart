import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 98,
                      width: 98,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                      color: Colors.white60
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                category.urlImage,
                                fit: BoxFit.cover,
                              ),
                            ),


                            SizedBox(height: 4),


                            Text(
                              category.name,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
