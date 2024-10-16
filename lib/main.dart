import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/presentation/controller/login_cubit.dart';
import 'features/splash_screen/views/splash_screen.dart';

void main() {
  runApp(

      MultiBlocProvider(
          providers: [

            BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(),
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
      home:splashscreen()
    );
  }
}
