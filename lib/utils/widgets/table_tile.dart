import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';

class TableTile extends StatelessWidget {
  final String tableNumber;
  final void Function()? onTap;
  const TableTile({
    super.key,
    this.onTap,
    required this.tableNumber,
  });

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
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: Text(
          tableNumber,
          style: kMediumTextStyle.copyWith(
              fontSize: 22.sp, color: AppColors.black),
        ),
      ),
    );
  }
}
