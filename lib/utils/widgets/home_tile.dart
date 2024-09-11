import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final bool isActive;
  final CrossAxisAlignment? crossAxisAlignment;
  const HomeTile(
      {super.key,
      this.onTap,
      required this.title,
      required this.subtitle,
      this.crossAxisAlignment,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 6.sp, bottom: 6.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: Colors.white,
            border:
                Border.all(color: Colors.black.withOpacity(0.2), width: 1.sp)),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: kMediumTextStyle.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? AppColors.black
                    : AppColors.black.withOpacity(0.2),
              ),
            ),
            Text(
              subtitle,
              style: kRegularTextStyle.copyWith(
                fontSize: 15.sp,
                color: isActive
                    ? AppColors.black.withOpacity(0.7)
                    : AppColors.black.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
