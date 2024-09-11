import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/common/base_textfield.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: inputField(lable: 'Vorname', title: "Rene"),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: inputField(lable: 'Vorname', title: "Gmeiner"),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: inputField(lable: 'Username', title: "renegmeiner"),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: inputField(lable: 'Unternehmensname', title: "Jahnhalle"),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: inputField(
                  lable: 'Emailadresse', title: "rene@daskartell.at"),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child:
                  inputField(lable: 'Telefonnummer', title: "+43 680 1525254"),
            ),
          ],
        ),
        SizedBox(height: 350.h),
        BaseButton(
          buttonText: 'Speichern',
          onPressed: () {},
        )
      ],
    );
  }

  inputField({required String lable, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lable,
            style: kMediumTextStyle.copyWith(
                color: AppColors.lightblack3, fontSize: 15.sp)),
        SizedBox(
          height: 5.h,
        ),
        BaseTextField(
          isRead: true,
          controller: TextEditingController(text: title),
          borderColor: Colors.black.withOpacity(0.2),
        ),
      ],
    );
  }
}
