import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/features/Greate_account/data/repo/Greate_account_impelemntation.dart';
import 'package:mrcandy/features/login/data/repo/login_repo_impelemntation.dart';

import 'features/Greate_account/presentation/controller/greate_account_cubit.dart';
import 'features/Home/presentation/controller/get_product/get_product_cubit.dart';
import 'features/login/presentation/controller/login_cubit.dart';
import 'features/splash_screen/views/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("setting");
  await ScreenUtil.ensureScreenSize();

  runApp(

      MultiBlocProvider(
          providers: [

            BlocProvider(create: (_) => ProductsCubit()..fetchproducts()),

            BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(LoginRepoImplementation()),
            ),
            BlocProvider<GreateAccountCubit>(
              create: (context) => GreateAccountCubit(GreateAccountImplementation()),
            ),

          ],
          child:  const MyApp()
      ));


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(

      designSize: const Size(375, 1006),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mr Candy',
          home: splashscreen(),
        );
      },
    );
  }
}

git remote add origin https://github.com/Elfouly2004/mr_candy

git remote set-url origin https://github.com/Elfouly2004/mr_candy
