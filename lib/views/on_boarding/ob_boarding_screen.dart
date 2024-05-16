import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home/layout_screen/layout_screen.dart';
import 'package:smart_home/views/home_screen/home_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h,),
              Image.asset('assets/animate.gif',
                height: 180.h,
                fit: BoxFit.fill,),
              SizedBox(height: 60.h,),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20.r),
                 color: Color(0xFF4D4D4D),
               ),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Enjoy with your ',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                       Text('smart Home',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                     ],
                   ),
                   SizedBox(height: 15.h,),
                   Text('A smart home saves you time and gets things done',
                     style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 18.sp),),
                   SizedBox(height: 70.h,),
                   MaterialButton(onPressed: () {
                     Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        },
                     minWidth: 200.w,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.r),
                     ),
                     color: Color(0xFF81ADFF),
                     padding: EdgeInsets.all(12.h),
                   child: Text('Get Started',style: TextStyle(color: Colors.white),),
                   )
                 ],
               ),
             )
            ],
          ),
        ),
      )
    );
  }
}
