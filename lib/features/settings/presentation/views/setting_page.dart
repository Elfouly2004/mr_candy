import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrcandy/core/shared_widgets/custom_appbar.dart';
import 'package:mrcandy/core/utils/app_texts.dart';
import 'package:mrcandy/features/settings/presentation/views/widgets/share_listile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Appbar as a widget
          SizedBox(
            height: 111.h, // نفس ارتفاع الـ AppBar
            child: const CustomAppbar(title: AppTexts.Setting),
          ),
          Expanded(
            child: Center(

                child: Column(
                  children: [


                    ShareListile(
                      onTap: () {},
                      title: Text(AppTexts.profile,style: GoogleFonts.actor( // تغيير الخط إلى Roboto أو أي خط آخر
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),),
                      leading: Icon(CupertinoIcons.profile_circled , size: 25.sp,),
                      trailing:  Icon(Icons.arrow_forward_ios_sharp),

                    ),
                  ],
                )

            ),
          ),
        ],
      ),
    );
  }
}
