import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/features/Category/presentation/view/widgets/gatgories_grid.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../Home/presentation/view/widgets/gridview_product.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({required this.title, required this.id});

  final String title;
final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 111.h,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.Appbar1,
                AppColors.Appbar2,
                AppColors.Appbar3,
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
          title: Text(
            title,
            style: GoogleFonts.almarai(
              color: AppColors.white,
              fontSize: 20.r, // حجم الخط
              fontWeight: FontWeight.bold, // سمك الخط
            ),
          ),
        centerTitle: true,
        leading:
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
            ),
          ),

      ),

      body: Container(
        color: Colors.white,
        child: Column(
          children: [

            Expanded(child: Padding(
              padding: const EdgeInsets.all(15),
              child: GatgoriesGrid(categoryId: id,),
            ))
          ],
        ),
      ),
    );
  }
}
