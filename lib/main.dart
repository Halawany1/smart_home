import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_home/controller/layout_cubit.dart';
import 'package:smart_home/core/notifications.dart';
import 'package:smart_home/views/on_boarding/ob_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  await LocalNotificationService().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit()..getData(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              nextScreen: OnBoardingScreen(),
              duration: 1000,
              animationDuration: Duration(seconds:2 ),
              splashIconSize: 300.w,
              backgroundColor: Color(0xFF121212),
              splash: 'assets/logo.png',
              curve: Curves.easeInOutBack,
              pageTransitionType: PageTransitionType.rightToLeftWithFade,
              splashTransition: SplashTransition.slideTransition,
            ),
          );
        },
      ),
    );
  }
}
