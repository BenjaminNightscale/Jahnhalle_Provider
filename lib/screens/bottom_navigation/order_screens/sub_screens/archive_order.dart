import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:provider/provider.dart';

class ArchiveOrder extends StatefulWidget {
  const ArchiveOrder({super.key});

  @override
  State<ArchiveOrder> createState() => _ArchiveOrderState();
}

class _ArchiveOrderState extends State<ArchiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Database>(builder: (context, db, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            'Tischbestellungen',
            style: kMediumTextStyle.copyWith(fontSize: 15.sp),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 800.h,
              maxWidth: 480.w,
            ),
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: db.getOrdersStream('fertig'), // Stream of orders
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final orderList = snapshot.data!;

                if (orderList.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                }

                return GridView.builder(
                  itemCount: orderList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 170.h,
                    crossAxisSpacing: 17.sp,
                    mainAxisSpacing: 10.sp,
                  ),
                  itemBuilder: (context, index) {
                    final order = orderList[index];

                    Timestamp createdAtTimestamp =
                        order['createdAt'] as Timestamp;
                    DateTime createdAt = createdAtTimestamp.toDate();
                    Duration difference = DateTime.now().difference(createdAt);
                    String waitingTime = db.formatDuration(difference);

                    // final drinks = order['items'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          db.updateOrderDetails(order, index);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.28),
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(
                            color: Colors.green,
                          ),
                        ),
                        padding: EdgeInsets.all(10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #${order['orderId'].toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                Text(
                                  '${order['table']['tableNumber']}',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.sp, horizontal: 10.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: Text(
                                    order['orderStatus'],
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  '${order['items'].length} Produkte',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                                Text(
                                  'vor $waitingTime',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
