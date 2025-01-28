import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrcandy/core/utils/app_colors.dart';
import 'package:mrcandy/features/carts/presentation/view/carts_page.dart';
import 'package:mrcandy/features/favorite/presentation/view/fav_page.dart';
import 'package:mrcandy/features/settings/presentation/views/setting_page.dart';
import 'home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const FavoritesPage(),
    const CartsPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // تحديد الطول الديناميكي بناءً على حجم الشاشة
    double deviceHeight = MediaQuery.of(context).size.height;
    double bottomNavHeight;

    if (deviceHeight == 890.2857142857143) {
      // الأجهزة الكبيرة
      bottomNavHeight = 70.h;
    } else if (deviceHeight > 860) {
      // الأجهزة الكبيرة
      bottomNavHeight = 100.h;
    }
    else if (deviceHeight > 700) {
      // الأجهزة الكبيرة
      bottomNavHeight = 110.h;
    } else if (deviceHeight > 600) {
      // الأجهزة المتوسطة
      bottomNavHeight = 70.h;
    } else {
      // الأجهزة الصغيرة
      bottomNavHeight = 60.h;
    }

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl, // لضبط الاتجاه من اليمين إلى اليسار
        child: Container(
          height: bottomNavHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.bottom_g1, // اللون الأول للتدرج
                AppColors.bottom_g2, // اللون الثاني للتدرج
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            border: Border.all(
              color: Colors.white, // لون الإطار
              width: 0, // سماكة الإطار
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // لتجنب تأثير اللون الافتراضي
            currentIndex: currentIndex,
            onTap: (bottomIndex) {
              setState(() {
                currentIndex = bottomIndex;
              });
            },
            selectedItemColor: Colors.white, // لون العنصر النشط
            unselectedItemColor: Colors.white.withOpacity(0.7), // لون العنصر غير النشط
            iconSize: 25.sp,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill, size: 25.sp),
                label: "الرئيسيه",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart, size: 25.sp),
                label: 'المفضله',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bag, size: 25.sp),
                label: 'السله',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 25.sp),
                label: 'الاعدادات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
