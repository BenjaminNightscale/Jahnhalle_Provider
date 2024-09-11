import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/common/images.dart';

class BaseAppBar extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final bool isHomePage;
  final bool showDivider;
  const BaseAppBar(
      {super.key,
      this.onTap,
      required this.title,
      this.isHomePage = true,
      this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: onTap,
                    child: Image.asset(
                        isHomePage
                            ? AppImages.drawerIcon
                            : AppImages.backArrowIcon,
                        scale: 2)),
                SizedBox(width: 15.w),
                Text(
                  title,
                  style: kMediumTextStyle.copyWith(
                      fontSize: 20.sp, color: AppColors.black),
                ),
              ],
            ),
            Text(
              'Rene Gmeiner',
              style: kMediumTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.black),
            )
          ],
        ),
        Visibility(
            visible: showDivider,
            child: Divider(color: AppColors.black, thickness: 1.sp)),
      ],
    );
  }
}
