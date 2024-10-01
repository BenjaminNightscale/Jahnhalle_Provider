import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/table_screens/add_table.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/table_screens/table_list.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/widgets/base_appbar.dart';
import 'package:jahnhalle_provider/utils/widgets/base_home.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(builder: (context, value, child) {
      return BaseHome(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 38.h, horizontal: 28.w),
          child: Column(
            children: [
              BaseAppBar(
                isHomePage: false,
                onTap: () {
                  if (value.isTablePage == false) {
                    value.changeTable(true);

                    value.changeTableTitle("Tisch");
                  } else {
                    value.onItemTapped(0);
                  }
                },
                title: value.tableTitle,
              ),
              if (value.isTablePage) ...[
                const TableList(),
                // Spacer(),
                SizedBox(
                  height: 30.h,
                ),
                BaseButton(
                  buttonText: 'Neuen Tisch erstellen',
                  onPressed: () {
                    value.changeTable(false);
                    value.changeTableTitle("Tisch anlegen");
                  },
                )
              ] else ...[
                const AddNewTable(),
              ],
            ],
          ),
        ),
      );
    });
  }
}
