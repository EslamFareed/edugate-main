import 'package:edugate/core/app_colors.dart';
import 'package:edugate/core/cache_helper.dart';
import 'package:edugate/features/applications/cubit/my_applications_cubit.dart';
import 'package:edugate/features/apply_for_university/cubit/apply_cubit.dart';
import 'package:edugate/features/home/cubit/home_cubit.dart';
import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:edugate/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:edugate/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ApplyCubit()),
        BlocProvider(create: (context) => MyApplicationsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
