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
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesFailureState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is CategoriesSuccessState) {
            final categories = context.read<CategoriesCubit>().categories_lst;

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10), // إزالة أي حشوات افتراضية حول الشبكة
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0, // إزالة المسافات الأفقية بين العناصر
                mainAxisSpacing: 10.0, // إزالة المسافات الرأسية بين العناصر
                childAspectRatio: 1.5,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          title: category.name,
                          id: category.id,
                        ),
                      ),
                    );
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white54,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // تصحيح تموضع العناصر عموديًا
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              category.urlImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
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
