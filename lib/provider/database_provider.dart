// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahnhalle_provider/utils/models/drinks_model.dart';

class Database with ChangeNotifier {
  final CollectionReference tables =
      FirebaseFirestore.instance.collection('tables');
  Future<bool> doesTableExist(String number) async {
    final querySnapshot =
        await tables.where('tableNumber', isEqualTo: number).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> addTable(
      {required BuildContext context, required String number}) async {
    // final int tableNumber = int.parse(number);
    bool isAdded = false;
    bool exists = await doesTableExist(number);
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Table already exist!')),
      );
      return isAdded;
    } else {
      try {
        await tables.add({
          'tableNumber': number,
          'capacity': "$_tableCapacity Personen",
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Table added successfully!')),
        // );
        isAdded = true;
        _tableCapacity = 0;
        log('Table added successfully!');
      } catch (e) {
        log('Failed to add table: $e');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to add table: $e')),
        // );
      }
      notifyListeners();
      return isAdded;
    }
  }

  int _tableCapacity = 0;
  int get tableCapacity => _tableCapacity;
  void capacityIncrement() {
    _tableCapacity++;
    log("capacityIncrement $tableCapacity");
    notifyListeners();
  }

  void capacityDecrement() {
    if (_tableCapacity != 0) {
      _tableCapacity--;
    }
    log("capacityDecrement $tableCapacity");
    notifyListeners();
  }

  dynamic _selectedOrder;
  get selectedOrder => _selectedOrder;

  int _selectedOrderIndex = -1;
  int get selectedOrderIndex => _selectedOrderIndex;

  Stream<List<Map<String, dynamic>>> getOrdersStream(String status) {
    log('message');
    return FirebaseFirestore.instance
        .collection('orders')
        .where('orderStatus', isEqualTo: status)
        .where("isDeleted", isEqualTo: false)
        .orderBy('orderId')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Future<List<Map<String, dynamic>>> getOrders(String orderStatus) async {
  //   try {
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('orders')
  //         .where('orderStatus', isEqualTo: orderStatus)
  //         .orderBy('orderId')
  //         .get();

  //     List<Map<String, dynamic>> orders = [];

  //     for (DocumentSnapshot doc in querySnapshot.docs) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //       // Convert orderId to int if necessary
  //       int orderId;
  //       if (data['orderId'] is int) {
  //         orderId = data['orderId'];
  //       } else if (data['orderId'] is String) {
  //         orderId = int.tryParse(data['orderId']) ??
  //             0; // Handle conversion from String to int
  //       } else {
  //         orderId = 0; // Default value if neither int nor String
  //       }

  //       List<Drink> drinks = (data['items'] as List<dynamic>).map((item) {
  //         return Drink.fromFirestore(item as Map<String, dynamic>);
  //       }).toList();
  //       // Calculate waiting time
  //       Timestamp createdAtTimestamp = data['createdAt'] as Timestamp;
  //       DateTime createdAt = createdAtTimestamp.toDate();
  //       Duration difference = DateTime.now().difference(createdAt);
  //       String waitingTime = formatDuration(difference);
  //       orders.add({
  //         'orderId': orderId,
  //         'tableNumber': data['table']['tableNumber'],
  //         'tableCapacity': data['table']['capacity'],
  //         'items': drinks,
  //         'status': data['orderStatus'], // Example status
  //         'waitingTime': waitingTime, // Example waiting time
  //       });
  //     }

  //     // updateOrderDetails(orders[0]);
  //     return orders;
  //   } catch (e) {
  //     log('Failed to fetch orders: $e');
  //     return [];
  //   }
  // }

  updateOrderDetails(dynamic order, int index) {
    log(">>>>>>> $order");
    if (order == null) {
      _selectedOrder = null;
    } else {
      _selectedOrder = order;
    }
    _selectedOrderIndex = index;
    notifyListeners();
  }

  Future<void> updateOrderStatus(
      {required int orderId, String? newStatus, required String status}) async {
    try {
      if (newStatus == null) {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId.toString())
            .update({
          'status': status,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(orderId.toString())
            .update({
          'orderStatus': newStatus,
          'status': status,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      log('Order status updated to $newStatus for order ID $orderId');
    } catch (e) {
      log('Failed to update order status: $e');
    }
  }

  Future<void> markOrderAsDelivered(
      {required int orderId, required String status}) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId.toString())
          .update({
        'status': status,
        'deliveredAt': FieldValue.serverTimestamp(),
      });

      log('OrderdeliveredAt to $status for order ID $orderId');
    } catch (e) {
      log('Failed to update order status: $e');
    }
  }

  Future<void> markOrderAsDelete({required int orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId.toString())
          .update({
        'isDeleted': true,
      });
      updateOrderDetails(null, -1);
      log('OrderDeleted order ID $orderId');
    } catch (e) {
      log('Failed to delete order: $e');
    }
  }

  void startStatusUpdateTimer(
      {required int orderId, required String newStatus}) {
    Timer(const Duration(seconds: 20), () async {
      await markOrderAsDelivered(
        orderId: orderId,
        status: newStatus,
      );
    });
  }

  // Helper method to format the duration
  String formatDuration(Duration duration) {
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds} sekunden';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minuten';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} stunden';
    } else {
      return '${duration.inDays} tagen';
    }
  }
}
