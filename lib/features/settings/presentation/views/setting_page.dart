import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/shared_widgets/custom_appbar.dart';
import 'package:mrcandy/core/utils/app_texts.dart';

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
          const Expanded(
            child: Center(

            ),
          ),
        ],
      ),
    );
  }
}
