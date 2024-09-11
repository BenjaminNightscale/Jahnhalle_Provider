import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/models/drinks_model.dart';
import 'package:provider/provider.dart';

class WaitingOrder extends StatefulWidget {
  const WaitingOrder({super.key});

  @override
  State<WaitingOrder> createState() => _WaitingOrderState();
}

class _WaitingOrderState extends State<WaitingOrder> {
  List<Map<String, dynamic>> orderList = [];
  Future<void> fetchOrders() async {
    orderList = await context.read<Database>().getOrders('wartend');
    setState(() {}); // Update the UI after fetching orders
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

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
          // ConstrainedBox(
          //   constraints: BoxConstraints(
          //     maxHeight: 800.h,
          //     maxWidth: 480.w,
          //   ),
          //   child:
          //       FutureBuilder<List<Map<String, dynamic>>>(
          //     future: db.getOrders('wartend'),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState ==
          //           ConnectionState.waiting) {
          //         return const Center(
          //             child: CircularProgressIndicator());
          //       }

          //       if (snapshot.hasError) {
          //         return Center(
          //             child:
          //                 Text('Error: ${snapshot.error}'));
          //       }

          //       if (!snapshot.hasData ||
          //           snapshot.data!.isEmpty) {
          //         return const Center(
          //             child: Text('No orders found.'));
          //       }

          //       orderList = snapshot.data!;

          //       return GridView.builder(
          //         itemCount: orderList.length,
          //         gridDelegate:
          //             SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           mainAxisExtent: 170.h,
          //           crossAxisSpacing: 17.sp,
          //           mainAxisSpacing: 10.sp,
          //         ),
          //         itemBuilder: (context, index) {
          //           final order = orderList[index];

          //           final drinks =
          //               order['items'] as List<Drink>;

          //           return GestureDetector(
          //             onTap: () {
          //               db.updateOrderDetails(order, index);
          //             },
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color:
          //                     db.selectedOrderIndex == index
          //                         ? Colors.orange
          //                             .withOpacity(0.28)
          //                         : Colors.blue
          //                             .withOpacity(0.28),
          //                 borderRadius:
          //                     BorderRadius.circular(15.sp),
          //                 border: Border.all(
          //                   color: db.selectedOrderIndex ==
          //                           index
          //                       ? Colors.orange
          //                       : Colors.blue,
          //                 ),
          //               ),
          //               padding: EdgeInsets.all(10.sp),
          //               child: Row(
          //                 mainAxisAlignment:
          //                     MainAxisAlignment
          //                         .spaceBetween,
          //                 children: [
          //                   Column(
          //                     crossAxisAlignment:
          //                         CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         'Order #${order['orderId'].toString()}',
          //                         style: TextStyle(
          //                             fontWeight:
          //                                 FontWeight.bold,
          //                             fontSize: 14.sp),
          //                       ),
          //                       Text(
          //                         '${order['tableNumber']}',
          //                         style: TextStyle(
          //                             fontSize: 12.sp,
          //                             color: Colors.black
          //                                 .withOpacity(
          //                                     0.4)),
          //                       ),
          //                     ],
          //                   ),
          //                   Column(
          //                     crossAxisAlignment:
          //                         CrossAxisAlignment.end,
          //                     children: [
          //                       Container(
          //                         padding:
          //                             EdgeInsets.symmetric(
          //                                 vertical: 2.sp,
          //                                 horizontal:
          //                                     10.sp),
          //                         decoration: BoxDecoration(
          //                           color:
          // db.selectedOrderIndex ==
          //         index
          //     ? Colors.orange
          //         .withOpacity(
          //             0.85)
          //     : Colors.blue
          //         .withOpacity(
          //             0.85),
          //                           borderRadius:
          //                               BorderRadius
          //                                   .circular(
          //                                       15.sp),
          //                         ),
          //                         child: Text(
          //                           order['status'],
          //                           style: TextStyle(
          //                               fontSize: 12.sp,
          //                               color:
          //                                   Colors.white),
          //                         ),
          //                       ),
          //                       Text(
          //                         '${drinks.length} Produkte',
          //                         style: TextStyle(
          //                             fontSize: 12.sp,
          //                             color: Colors.black
          //                                 .withOpacity(
          //                                     0.4)),
          //                       ),
          //                       Text(
          //                         'vor ${order['waitingTime']}',
          //                         style: TextStyle(
          //                             fontSize: 12.sp,
          //                             color: Colors.black
          //                                 .withOpacity(
          //                                     0.4)),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // )
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 800.h,
              maxWidth: 480.w,
            ),
            child: orderList.isEmpty
                ? const Center(child: Text('No orders found.'))
                : GridView.builder(
                    itemCount: orderList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 170.h,
                      crossAxisSpacing: 17.sp,
                      mainAxisSpacing: 10.sp,
                    ),
                    itemBuilder: (context, index) {
                      final order = orderList[index];
                      final drinks = order['items'] as List<Drink>;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Modify the order details directly, if needed
                            db.updateOrderDetails(order, index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: db.selectedOrderIndex == index
                                ? Colors.orange.withOpacity(0.28)
                                : Colors.blue.withOpacity(0.28),
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border.all(
                              color: db.selectedOrderIndex == index
                                  ? Colors.orange
                                  : Colors.blue,
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
                                    '${order['tableNumber']}',
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
                                      color: db.selectedOrderIndex == index
                                          ? Colors.orange.withOpacity(0.85)
                                          : Colors.blue.withOpacity(0.85),
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    child: Text(
                                      order['status'],
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    '${drinks.length} Produkte',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black.withOpacity(0.4)),
                                  ),
                                  Text(
                                    'vor ${order['waitingTime']}',
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
                  ),
          ),
        ],
      );
    });
  }
}
