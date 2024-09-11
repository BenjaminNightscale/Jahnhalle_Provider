import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/sub_screens/home_screen.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/order_screens/order_screen.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/table_screens/table_screen.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/common/images.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class BaseBottomNavigationScreen extends StatefulWidget {
  final int? selectedIndex;
  const BaseBottomNavigationScreen({super.key, this.selectedIndex});

  @override
  State<BaseBottomNavigationScreen> createState() =>
      _BaseBottomNavigationScreenState();
}

class _BaseBottomNavigationScreenState
    extends State<BaseBottomNavigationScreen> {
  List<BottomBarItem> bottomBarItems = [
    BottomBarItem(icon: AppImages.homeIcon, screen: const HomeScreen()),
    BottomBarItem(icon: AppImages.editIcon, screen: Container()),
    BottomBarItem(icon: AppImages.calenderIcon, screen: Container()),
    BottomBarItem(icon: AppImages.eventIcon, screen: Container()),
    BottomBarItem(icon: AppImages.tableIcon, screen: const TableScreen()),
    BottomBarItem(icon: AppImages.staticsIcon, screen: Container()),
    BottomBarItem(icon: AppImages.foodIcon, screen: const OrderScreen()),
  ];

  // This method will be triggered when an item is tapped

  @override
  void initState() {
    if (widget.selectedIndex != null) {
      context.read<BottomBarProvider>().initialSelectedIndex =
          widget.selectedIndex ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(builder: (context, value, child) {
      return Scaffold(
        body: bottomBarItems[value.selectedIndex].screen,
        backgroundColor: AppColors.black,
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 70.w, right: 70.w, bottom: 60.h),
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          height: 95.h,
          decoration: BoxDecoration(
            color: AppColors.lightgrey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.sp),
              bottomRight: Radius.circular(12.sp),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AppImages.bottomBarIcon, scale: 2.2),
              value.isHome
                  ? Row(
                      children: List.generate(bottomBarItems.length, (index) {
                        return GestureDetector(
                          onTap: () => value.onItemTapped(index),
                          child: Container(
                            height: 30.sp,
                            width: 30.sp,
                            decoration: BoxDecoration(
                                color: value.selectedIndex == index
                                    ? AppColors.lightblack
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.sp)),
                            padding: EdgeInsets.all(2.sp),
                            margin: EdgeInsets.symmetric(
                                vertical: 2.sp, horizontal: 2.sp),
                            child: Image.asset(
                              bottomBarItems[index].icon,
                              scale: 2,
                              color: value.selectedIndex == index
                                  ? AppColors.lightgrey
                                  : AppColors.lightblack,
                            ),
                          ),
                        );
                      }),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
}

class BottomBarItem {
  String icon;
  Widget screen;
  BottomBarItem({required this.icon, required this.screen});
}
