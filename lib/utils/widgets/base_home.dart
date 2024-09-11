import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/widgets/base_drawer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class BaseHome extends StatelessWidget {
  final Widget child;
  const BaseHome({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: const BaseDrawer(),
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(
              left: 45.sp, right: 45.sp, top: 35.sp, bottom: 5.sp),
          decoration: BoxDecoration(
            color: AppColors.lightgrey,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: child,
        ));
  }
}
