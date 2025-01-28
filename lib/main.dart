import 'package:device_preview/device_preview.dart';
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
    DevicePreview(
      enabled: true, // قم بتعيين `false` عند إصدار التطبيق
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductsCubit()..fetchproducts()),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(LoginRepoImplementation()),
          ),
          BlocProvider<GreateAccountCubit>(
            create: (context) => GreateAccountCubit(GreateAccountImplementation()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1006),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mr Candy',
          home: const splashscreen(),
          // Enable Device Preview integration
          builder: DevicePreview.appBuilder, // يجعل التطبيق يعمل ضمن Device Preview
        );
      },
    );
  }
}
