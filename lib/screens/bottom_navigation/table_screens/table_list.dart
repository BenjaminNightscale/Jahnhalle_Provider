import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/utils/widgets/table_tile.dart';
import 'package:provider/provider.dart';

class TableList extends StatelessWidget {
  const TableList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomBarProvider, Database>(
        builder: (context, value, db, child) {
      return StreamBuilder<QuerySnapshot>(
        stream: db.tables.orderBy('tableNumber', descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }

          final List<DocumentSnapshot> tableDocs = snapshot.data!.docs;

          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tableDocs.length,
              itemBuilder: (context, index) {
                final tableData =
                    tableDocs[index].data() as Map<String, dynamic>;
                final tableNumber = tableData['tableNumber'];
                // final capacity = tableData['capacity'];

                return TableTile(tableNumber: tableNumber);
              },
            ),
          );
        },
      );
    });

    // Column(
    //   children: [
    //     Expanded(
    //       child: ListView.builder(
    //         itemBuilder: (context, index) =>
    //             const TableTile(tableNumber: "Tisch 30"),
    //         shrinkWrap: true,
    //         itemCount: 2,
    //       ),
    //     ),
    // SizedBox(height: 20.h),
    // BaseButton(
    //   buttonText: 'Neuen Tisch erstellen',
    //   onPressed: () {
    //     value.changeTable(false);
    //     value.changeTableTitle("Tisch anlegen");
    //   },
    // )
    //   ],
    // );
  }
}
