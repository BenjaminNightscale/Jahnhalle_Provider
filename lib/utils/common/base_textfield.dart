import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';

class BaseTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool isRead;
  final Color? borderColor;
  final Widget? prefix;
  final TextInputType? keyboardType;
  const BaseTextField(
      {super.key,
      this.hintText,
      this.keyboardType,
      this.controller,
      this.isRead = false,
      this.borderColor,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background
        borderRadius:
            BorderRadius.circular(8.sp), // Optional, depending on your needs
      ),
      height: 90.h,
      child: TextFormField(
        controller: controller,
        readOnly: isRead,
        keyboardType: keyboardType,
        style:
            kMediumTextStyle.copyWith(fontSize: 18.sp, color: AppColors.black),
        decoration: InputDecoration(
          prefix: prefix,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.only(bottom: 5.h, left: 10.w, right: 10.w),
          labelText: hintText,
          labelStyle: kMediumTextStyle.copyWith(
              fontSize: 18.sp, color: AppColors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.black,
              width: 1.5.sp,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.black,
              width: 1.5.sp,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
              borderSide: BorderSide(
                  color: borderColor ?? AppColors.black, width: 1.5.sp)),
        ),
      ),
    );
  }
}
