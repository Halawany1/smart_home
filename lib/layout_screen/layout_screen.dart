import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home/controller/layout_cubit.dart';
import 'package:smart_home/views/home_screen/home_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          backgroundColor: Color(0xFF121212),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                cubit.screens.length, (index) => cubit.screens[index]),
          ),
          extendBody: true,
          bottomNavigationBar: (cubit.screens.length <= 2)
              ? AnimatedNotchBottomBar(
                  color: Color(0xFF4D4D4D),
                  showLabel: true,
                  textOverflow: TextOverflow.visible,
                  maxLine: 1,
                  shadowElevation: 5,
                  kBottomRadius: 28.0,
                  notchColor: Colors.white,

                  /// restart app if you change removeMargins
                  removeMargins: false,
                  showShadow: false,
                  durationInMilliSeconds: 500,
                          bottomBarWidth: 50.w,
                  itemLabelStyle: TextStyle(
                      fontSize: 10.sp,
                      color: Color(0xFFB7B7B7),
                      fontWeight: FontWeight.w700),
                  elevation: 1,
                  bottomBarItems: const [
                    BottomBarItem(
                      inActiveItem:
                          Icon(Icons.home_outlined, color: Color(0xFFB7B7B7)),
                      activeItem: Icon(
                        Icons.home_filled,
                        color: Colors.blueAccent,
                      ),
                      itemLabel: 'Home',
                    ),
                    BottomBarItem(
                      inActiveItem: Icon(Icons.star_border_outlined, color: Color(0xFFB7B7B7)),
                      activeItem: Icon(
                        Icons.star,
                        color: Colors.blueAccent,
                      ),
                      itemLabel: 'Analysis',
                    ),
                  ],
                  onTap: (index) {
                    cubit.changeIndex(index);
                    pageController.jumpToPage(index);
                  },
                  kIconSize: 24.0,
                  notchBottomBarController:
                      NotchBottomBarController(index: cubit.index),
                )
              : null,
        );
      },
    );
  }
}
