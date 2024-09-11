import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/bottom_naigation_screen.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/common/base_textfield.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/common/images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 165.h),
                        Image.asset(
                          AppImages.loginLogo,
                          // width: 142.sp,
                          // height: 40.sp,
                          scale: 2,
                        ),
                        SizedBox(height: 150.h),
                        Text(
                          'Nightscale Business Login',
                          style: kBoldTextStyle.copyWith(
                              fontSize: 30.sp, color: AppColors.black),
                        ),
                        Text(
                          'Gib deine Accountdaten ein um dich anzumelden',
                          style: kRegularTextStyle.copyWith(
                              fontSize: 20.sp, color: AppColors.black),
                        ),
                        SizedBox(height: 30.h),
                        const BaseTextField(hintText: 'Benutzername'),
                        SizedBox(height: 50.h),
                        const BaseTextField(hintText: 'Passwort'),
                        SizedBox(height: 15.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Passwort vergessen',
                            style: kMediumTextStyle.copyWith(
                                color: AppColors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.blue),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        BaseButton(
                          buttonText: 'Anmelden',
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const BaseBottomNavigationScreen()));
                          },
                        ),
                        SizedBox(height: 500.h)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 40.sp, horizontal: 35.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.sp),
                    image: const DecorationImage(
                      image: AssetImage(AppImages.loginImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 120.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 40.h),
                    Text('Probleme?',
                        style: kRegularTextStyle.copyWith(
                            color: AppColors.grey, fontSize: 18.sp)),
                    Text('Frag Benjamin',
                        style: kBoldTextStyle.copyWith(
                            color: AppColors.blue, fontSize: 18.sp)),
                  ],
                ),
                SizedBox(width: 10.w),
                CircleAvatar(
                  radius: 40.sp,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 35.sp,
                    backgroundColor: Colors.black,
                  ),
                ),
                SizedBox(width: 60.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
