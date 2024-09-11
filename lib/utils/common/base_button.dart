import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';

class BaseButton extends StatelessWidget {
  final String buttonText;
  final double? textSize;
  final void Function()? onPressed;
  const BaseButton(
      {super.key, required this.buttonText, this.onPressed, this.textSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: kMediumTextStyle.copyWith(
                fontSize: textSize ?? 20.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
