import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/order_screens/order_detail_widget.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/order_screens/sub_screens/archive_order.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/order_screens/sub_screens/waiting_order.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/widgets/base_appbar.dart';
import 'package:jahnhalle_provider/utils/widgets/base_home.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int tabIndex = 0;
  // List orderList = [];
  List<Map<String, dynamic>> orderList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomBarProvider, Database>(
        builder: (context, value, db, child) {
      return DefaultTabController(
        initialIndex: tabIndex,
        length: 2,
        child: BaseHome(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 38.h, horizontal: 28.w),
                child: Column(
                  children: [
                    BaseAppBar(
                      isHomePage: false,
                      showDivider: false,
                      onTap: () {
                        value.onItemTapped(0);
                      },
                      title: "Bestellungen",
                    ),
                    TabBar(
                      onTap: (value) {
                        setState(() {
                          tabIndex = value;
                          db.updateOrderDetails(null, -1);
                        });
                      },
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelColor: AppColors.black,
                      labelStyle: kMediumTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                      unselectedLabelColor: AppColors.lightgrey3,
                      unselectedLabelStyle: kMediumTextStyle.copyWith(
                        fontSize: 12.sp,
                      ),
                      indicatorWeight: 0.1,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(right: 30.sp),
                          child: const Tab(text: "Wartend"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30.sp),
                          child: const Tab(text: "Archiv"),
                        ),
                      ],
                      dividerColor: AppColors.black,
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          WaitingOrder(),
                          ArchiveOrder(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const OrderDetail()
            ],
          ),
        ),
      );
    });
  }
}

class OrderData {
  String orderNumber;
  String status;
  String tablenNmber;
  String products;
  String waitingTime;

  OrderData(
      {required this.orderNumber,
      required this.status,
      required this.tablenNmber,
      required this.products,
      required this.waitingTime});
}
