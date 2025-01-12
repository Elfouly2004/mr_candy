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

  int CurrentIndex =  0;

  List<Widget> screens  = [
    HomePage(),
    FavoritesPage(),
    CartsPage(),
    SettingPage()

  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[CurrentIndex],


      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl, // لضبط الاتجاه من اليمين إلى اليسار
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.bottom_g1, // اللون الأول للتدرج
                AppColors.bottom_g2, // اللون الثاني للتدرج
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            border: Border.all(
              color: Colors.white, // لون الإطار
              width: 0,         // سماكة الإطار
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // لتجنب تأثير اللون الافتراضي
            currentIndex: CurrentIndex,
            onTap: (bottomIndex) {
              setState(() {
                CurrentIndex = bottomIndex;
              });
            },
            selectedItemColor: Colors.white, // لون العنصر النشط
            unselectedItemColor: Colors.white.withOpacity(1), // لون العنصر غير النشط
            iconSize: 30,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill,size: 30.r,),
                label: "الرئيسيه",

              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart,size: 30.r),
                label: 'المفضله',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bag,size: 30.r),
                label: 'السله',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,size: 30.r),
                label: 'الاعدادات',
              ),
            ],
          ),
        ),
      ),



    );
  }
}
