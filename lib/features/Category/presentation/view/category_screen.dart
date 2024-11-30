import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CategoryScreen extends StatelessWidget {
  // CategoryScreen({});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          // النصف الأول مع gradient
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                gradient: LinearGradient(
                  colors: [
                    AppColors.Appbar1,
                    AppColors.Appbar2,
                    AppColors.Appbar3,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Row(

                children: [
                  Expanded(
                    child: Center(
                      child: Text("aaaaaaaaaa"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined, color: AppColors.white,),
                  ),
                ],
              ),


            ),
          ),
          // النصف الثاني بالأبيض
          Expanded(
            flex: 12,
            child: Container(
              color: Colors.white,
              child: Column(

              ),
            ),
          ),
        ],
      ),
    );
  }
}
