
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_home/controller/layout_cubit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    String getCurrentTimeFormatted() {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('hh:mm a').format(now);
      return formattedTime;
    }

    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF121212),
          body: cubit.dataModel != null
              ? SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40.r,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.r),
                                    child: Image.asset(
                                      'assets/photo.jpg',
                                      fit: BoxFit.cover,
                                      width: 100.w,
                                      height: 100.w,
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello Owner',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'Welcome to your home.',
                                    style: TextStyle(
                                      color: Color(0xFF9E9E9E),
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Water Level',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          SizedBox(
                            height: 150.h,
                            child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: AnimationFlow()),
                                  Positioned(
                                    top: 15.h,
                                    left: 20.h,
                                    child: Text(
                                      getCurrentTimeFormatted(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 38.h,
                                    left: 20.h,
                                    child: Text(
                                      '${cubit.dataModel!.waterLevel} cm',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,),
                                    ),
                                  ),
                                ],
                                ),
                          ),
                          SizedBox(height: 25.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                  children: [
                                    Image.asset('assets/humenity.png',width: 150.w,),
                                    Positioned(
                                      top: 35.h,
                                      left: 40.h,
                                      child: Text('${cubit.dataModel!.humidity} °C',
                                        style: TextStyle(color: Colors.black,fontSize: 13.sp),),
                                    ),
                                  ],
                                  ),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Temperature',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 220.h,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: 0,
                                        maximum: 70,
                                        ranges: <GaugeRange>[
                                          GaugeRange(
                                              startValue: 0,
                                              endValue: 20,
                                              color: Colors.blue),
                                          GaugeRange(
                                              startValue: 20,
                                              endValue: 45,
                                              color: Colors.orange),
                                          GaugeRange(
                                              startValue: 45,
                                              endValue: 70,
                                              color: Colors.red)
                                        ],
                                        pointers: <GaugePointer>[
                                          NeedlePointer(value: double.parse(cubit.dataModel!.temp.toString()))
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Text(
                                                  cubit.dataModel!.temp
                                                      .toStringAsFixed(1)+' °C',
                                                  style: TextStyle(
                                                      fontSize: 25.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              angle: 90,
                                              positionFactor: 0.5)
                                        ])
                                  ])),

                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Gas',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          SfLinearGauge(
                            axisLabelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.9)
                            ),
                              markerPointers: [
                            LinearShapePointer(value: cubit.dataModel!.gas.toDouble(),
                                color: Colors.redAccent,height: 25.h, width: 25.w)
                          ]),
                          SizedBox(height: 60.h,),
                          Row(
                            children: [
                              Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: cubit.dataModel!.buzzer!?
                                  Colors.red:Color(0xFF4D4D4D),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.all(12.h),
                                 child: Column(
                                   children: [
                                     Row(children: [
                                       Icon(CupertinoIcons.bell_circle,color:  cubit.dataModel!.buzzer!?
                                           Colors.black:Colors.white,size: 30.r,),
                                       SizedBox(width: 10.w,),
                                       Text('Buzzer',
                                         style: TextStyle(color:  cubit.dataModel!.buzzer!?Colors.black:Colors.white,
                                             fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                     ],),
                                   ],
                                 ),
                              ),
                
                            ],
                          ),
                          SizedBox(height: 40.h,),
                        ],
                      ),
                    ),
                  ),
              )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                )),
        );
      },
    );
  }
}


class AnimationFlow extends StatefulWidget {
  @override
  _AnimationFlowState createState() => _AnimationFlowState();
}

class _AnimationFlowState extends State<AnimationFlow>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late Animation<double> animation1;

  late AnimationController controller2;
  late Animation<double> animation2;

  late AnimationController controller3;
  late Animation<double> animation3;

  late AnimationController controller4;
  late Animation<double> animation4;

  double waterLevel = 0.5; // Initial water level

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation1 = Tween<double>(begin: 1.9, end: 2.1)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    // Initialize other controllers and animations similarly...
    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation2 = Tween<double>(begin: 1.9, end: 2.1)
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut));
    // Initialize controller3 and animation3
    controller3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation3 = Tween<double>(begin: 1.9, end: 2.1)
        .animate(CurvedAnimation(parent: controller3, curve: Curves.easeInOut));
    // Initialize controller4 and animation4
    controller4 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation4 = Tween<double>(begin: 1.9, end: 2.1)
        .animate(CurvedAnimation(parent: controller4, curve: Curves.easeInOut));

    // Start animation sequences
    controller4.forward();

    Timer(Duration(milliseconds: 800), () {
      controller3.forward();
    });
    Timer(Duration(milliseconds: 1600), () {
      controller2.forward();
    });
    Timer(Duration(milliseconds: 2000), () {
      controller1.forward();
    });

    // Example: increase water level after 2 seconds
    Timer(Duration(seconds: 2), () {
      setState(() {
        waterLevel += 0.1; // Increase water level by 0.1
      });
    });
  }



  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CustomPaint(
              painter: MyPainter(animation1.value, animation2.value,
                  animation3.value, animation4.value, waterLevel),
              child: SizedBox(
                height: h,
                width: w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double h1;
  final double h2;
  final double h3;
  final double h4;
  final double waterLevel;

  MyPainter(this.h1, this.h2, this.h3, this.h4, this.waterLevel);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint
      ..color = Colors.blue.withOpacity(.7)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height / h1);

    path.cubicTo(size.width * .4, size.height / h2, size.width * .7,
        size.height / h3, size.width, size.height / h4);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);

    // Calculate the height of the water level rectangle based on the water level
    double waterHeight = size.height * waterLevel;

    // Draw water level rectangle
    var waterPaint = Paint();
    waterPaint.color = Colors.blue.withOpacity(0.5);
    canvas.drawRect(Rect.fromLTWH(0, size.height - waterHeight, size.width, waterHeight), waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
