import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/carts/presentation/view/Richtxt.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/shared_widgets/custom_appbar.dart';
import '../controller/carts_cubit.dart';
import '../controller/carts_state.dart';
import 'lstview.dart';

class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartsCubit>(
      create: (context) => CartsCubit()..fetchCarts(),
      child: Scaffold(
        body: Column(
          children: [
            // Custom AppBar widget
            SizedBox(
              height: 111.h,
              child: CustomAppbar(title: AppTexts.bag),
            ),
            Expanded(
              child: BlocBuilder<CartsCubit, CartsState>(
                builder: (context, state) {
                  if (state is CartsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartsFailureState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is CartsSuccessState) {
                    final cartItems = state.cartsList;

                    if (cartItems.isEmpty) {
                      return const Center(child: Text("No items in your cart"));
                    }

                    return Lstview(
                      itemCount: cartItems.length,
                       cartitems:cartItems ,);
                  }

                  return const Center(child: Text("Something went wrong!"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
