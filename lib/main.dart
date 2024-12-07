import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrcandy/features/Greate_account/data/repo/Greate_account_impelemntation.dart';
import 'package:mrcandy/features/Home/presentation/view/home_screen.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/home.dart';
import 'package:mrcandy/features/Home/presentation/view/widgets/home_page.dart';
import 'package:mrcandy/features/login/data/repo/login_repo_impelemntation.dart';
import 'package:mrcandy/features/login/presentation/view/Login.dart';

import 'features/Greate_account/presentation/controller/greate_account_cubit.dart';
import 'features/Home/presentation/view/widgets/gridview_categories.dart';
import 'features/login/presentation/controller/login_cubit.dart';
import 'features/onboarding/peresentation/views/custom_onboarding.dart';
import 'features/splash_screen/views/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("setting");

  runApp(

      MultiBlocProvider(
          providers: [

            BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(LoginRepoImplementation()),
            ),
            BlocProvider<GreateAccountCubit>(
              create: (context) => GreateAccountCubit(GreateAccountImplementation()),
            ),

          ],
          child:  MyApp()
      ));


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mr Candy',
      home: splashscreen(),
    );
  }
}