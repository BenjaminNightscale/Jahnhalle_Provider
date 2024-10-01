import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:jahnhalle_provider/utils/common/images.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  final int tabIndex;
  const OrderDetail({super.key, required this.tabIndex});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  OverlayState? overlayState;
  OverlayEntry? _overlayEntry;

  void _showOverlayDialog(BuildContext context, {required int orderId}) {
    overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.64,
          child: Material(
            color: Colors.transparent,
            child: _buildDialogContent(context, orderId: orderId),
          ),
        ),
      );

      overlayState?.insert(_overlayEntry!);
    }
  }

  Widget _buildDialogContent(BuildContext context, {required int orderId}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.sp),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Bestellung stornieren',
                style: kMediumTextStyle.copyWith(
                    fontSize: 12.sp, color: AppColors.lightgrey3)),
          ),
          SizedBox(height: 2.sp),
          Text('Wollen Sie die Bestellung unwiderruflich stornieren?',
              textAlign: TextAlign.center,
              style: kRegularTextStyle.copyWith(
                  fontSize: 12.sp, color: AppColors.lightgrey3)),
          SizedBox(height: 10.sp),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Divider(),
              TextButton(
                  onPressed: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                    overlayState = null;
                    context
                        .read<Database>()
                        .markOrderAsDelete(orderId: orderId);
                  },
                  child: Text(
                    'Ja, stornieren',
                    style: kRegularTextStyle.copyWith(
                        color: Colors.blue, fontSize: 14.sp),
                  )),
              const Divider(),
              TextButton(
                  onPressed: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                    overlayState = null;
                  },
                  child: Text(
                    'Nein, abbrechen',
                    style: kRegularTextStyle.copyWith(
                        color: Colors.red, fontSize: 14.sp),
                  )),
              SizedBox(
                height: 5.sp,
              )
            ],
          ),
        ],
      ),
    );
  }

  void removeOverLay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverLay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Database>(builder: (context, db, child) {
      log("selected order ===> ${db.selectedOrder}");
      return GestureDetector(
        onTap: () {
          removeOverLay();
        },
        child: Container(
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
          child: db.selectedOrder == null
              ? const Center(
                  child: Text('Please select an order to see details.'),
                )
              : Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            db.selectedOrder['table']['tableNumber'],
                            style: kMediumTextStyle.copyWith(fontSize: 20.sp),
                          ),
                          Visibility(
                            visible: widget.tabIndex == 0,
                            child: IconButton(
                              onPressed: () {
                                removeOverLay();
                                _showOverlayDialog(context,
                                    orderId: db.selectedOrder['orderId']);
                              },
                              icon: Image.asset(
                                AppImages.deleteIcon,
                                scale: 2.5,
                              ),
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
                            db.selectedOrder!['table']['capacity'],
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
                          itemCount: (db.selectedOrder!['items']).length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            child: Text(
                                                drink['quantity'].toString()),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            drink['name'],
                                            style: kMediumTextStyle.copyWith(
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          Text(
                                            drink['category'].toString(),
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
                                    "€ ${(drink['quantity'] * drink['price']).toStringAsFixed(2)}",
                                    style: kRegularTextStyle.copyWith(
                                        fontSize: 18.sp,
                                        color:
                                            AppColors.black.withOpacity(0.6)),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.tabIndex != 0) ...[
                        BaseButton(
                          buttonText: 'Rechnung drucken',
                          textSize: 15.sp,
                          buttonTxtcolor: Colors.black.withOpacity(0.4),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightgrey,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                          onPressed: () async {},
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
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
                            db.updateOrderDetails(null, -1);
                          });
                        },
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
