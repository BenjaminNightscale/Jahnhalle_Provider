import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/common/images.dart';
import 'package:jahnhalle_provider/utils/models/drinks_model.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  // void _showOverlayDialog(BuildContext context) {
  //   final overlay = Overlay.of(context);
  //   final overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: MediaQuery.of(context).size.height * 0.4,
  //       left: MediaQuery.of(context).size.width * 0.2,
  //       child: Material(
  //         color: Colors.transparent,
  //         child: _buildDialogContent(context),
  //       ),
  //     ),
  //   );

  //   overlay?.insert(overlayEntry);
  // }

  // Widget _buildDialogContent(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.6,
  //     padding: EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.2),
  //           blurRadius: 8.0,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text(
  //           'Bestellung stornieren',
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 10),
  //         Text(
  //           'Wollen Sie die Bestellung unwiderruflich stornieren?',
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(height: 20),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 // Handle the cancellation logic
  //                 Navigator.of(context).pop(); // Close the overlay
  //               },
  //               child: Text('Ja, stornieren'),
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.blue,
  //                 textStyle: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the overlay
  //               },
  //               child: Text('Nein, abbrechen'),
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.red,
  //                 textStyle: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<Database>(builder: (context, db, child) {
      return Container(
        height: double.infinity,
        width: 400.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.sp),
            bottomRight: Radius.circular(15.sp),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 28.w),
        child: db.selectedOrder != null
            ? Padding(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          db.selectedOrder!['tableNumber'],
                          style: kMediumTextStyle.copyWith(fontSize: 20.sp),
                        ),
                        IconButton(
                          onPressed: () {
                            // _showOverlayDialog(context);
                          },
                          icon: Image.asset(
                            AppImages.deleteIcon,
                            scale: 2.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pius Martin',
                          style: kMediumTextStyle.copyWith(
                              fontSize: 12.sp, color: AppColors.lightgrey3),
                        ),
                        Text(
                          'Order #${db.selectedOrder['orderId']}',
                          style: kMediumTextStyle.copyWith(
                              fontSize: 12.sp, color: AppColors.lightgrey3),
                        ),
                        Text(
                          db.selectedOrder!['tableCapacity'],
                          style: kMediumTextStyle.copyWith(
                              fontSize: 12.sp, color: AppColors.lightgrey3),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            (db.selectedOrder!['items'] as List<Drink>).length,
                        itemBuilder: (context, index) {
                          final drink = db.selectedOrder!['items'][index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.sp),
                            padding: EdgeInsets.all(15.sp),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.lightgrey,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.2),
                                      radius: 15.sp,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 14.sp,
                                        child: Center(
                                          child:
                                              Text(drink.quantity.toString()),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          drink.name,
                                          style: kMediumTextStyle.copyWith(
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        Text(
                                          drink.category.toString(),
                                          style: kMediumTextStyle.copyWith(
                                              fontSize: 14.sp,
                                              color: AppColors.black
                                                  .withOpacity(0.6)),
                                        ),
                                        SizedBox(height: 5.h),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "€ ${(drink.quantity * drink.price).toStringAsFixed(2)}",
                                  style: kRegularTextStyle.copyWith(
                                      fontSize: 18.sp,
                                      color: AppColors.black.withOpacity(0.6)),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    BaseButton(
                      buttonText: 'Bon Drucken',
                      textSize: 15.sp,
                      onPressed: () async {
                        await db
                            .updateOrderStatus(
                                orderId: db.selectedOrder!['orderId'],
                                newStatus: "fertig",
                                status: "Bestellung in Bearbeitung")
                            .then((value) {
                          db.startStatusUpdateTimer(
                              orderId: db.selectedOrder!['orderId'],
                              newStatus: 'Bestellung geliefert');
                        });
                      },
                    )
                  ],
                ),
              )
            : const Center(
                child: Text('Please select an order to see details.'),
              ),
      );
    });
  }
}
