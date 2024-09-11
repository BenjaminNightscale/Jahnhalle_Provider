import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/common/images.dart';
import 'package:provider/provider.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 32.w, right: 32.w),
        margin: EdgeInsets.only(
            left: 45.sp, right: 45.sp, top: 35.sp, bottom: 5.sp),
        decoration: BoxDecoration(
          color: AppColors.lightgrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            bottomLeft: Radius.circular(15.sp),
          ),
        ),
        width: 350.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Text('Admin',
                style: kRegularTextStyle.copyWith(
                    fontSize: 18.sp, color: AppColors.lightgrey2)),
            Text('Rene Gmeiner',
                style: kRegularTextStyle.copyWith(
                    fontSize: 30.sp, color: AppColors.black)),
            SizedBox(height: 20.h),
            Container(height: 4.h, color: AppColors.lightblack2),
            SizedBox(height: 28.h),
            inputField(
                onTap: () {
                  context.read<BottomBarProvider>().changeTitle('Home');
                  context.read<BottomBarProvider>().changeHomePage(true);
                  Navigator.pop(context);
                },
                icon: AppImages.drawerHome,
                label: 'Home',
                color: Colors.black.withOpacity(0.5)),
            SizedBox(height: 20.h),
            inputField(
                onTap: () {
                  context.read<BottomBarProvider>().changeTitle('Profil');
                  context.read<BottomBarProvider>().changeHomePage(false);
                  Navigator.pop(context);
                },
                icon: AppImages.drawerProfile,
                label: 'Profil',
                color: Colors.black.withOpacity(0.5)),
            const Spacer(),
            inputField(
                onTap: () {},
                icon: AppImages.drawerHelp,
                label: 'Hilfe',
                color: Colors.black.withOpacity(0.5)),
            SizedBox(height: 20.h),
            inputField(
                onTap: () {},
                icon: AppImages.drawerLogout,
                label: 'Ausloggen',
                color: Colors.black),
            SizedBox(height: 32.h),
          ],
        ));
  }

  inputField(
      {required String icon,
      required String label,
      required Color color,
      required void Function() onTap}) {
    return InkWell(
        onTap: onTap,
        child: Row(children: [
          Image.asset(icon, scale: 2, color: color),
          SizedBox(width: 8.w),
          Text(label,
              style: kMediumTextStyle.copyWith(fontSize: 20.sp, color: color))
        ]));
  }
}
