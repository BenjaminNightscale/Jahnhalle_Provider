import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/provider/database_provider.dart';
import 'package:jahnhalle_provider/utils/common/app_theme.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/common/base_textfield.dart';
import 'package:jahnhalle_provider/utils/common/colors.dart';
import 'package:provider/provider.dart';

class AddNewTable extends StatefulWidget {
  const AddNewTable({super.key});

  @override
  State<AddNewTable> createState() => _AddNewTableState();
}

class _AddNewTableState extends State<AddNewTable> {
  final String fixedText = "Tisch ";
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: fixedText);

    // Listen to changes in the text field
    _controller.addListener(() {
      // If the text doesn't start with the fixed text, reset it
      if (!_controller.text.startsWith(fixedText)) {
        _controller.text = fixedText;
        // Move the cursor to the end of the text
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomBarProvider, Database>(
        builder: (context, value, db, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 60.h),
          Row(
            children: [
              Expanded(
                  child: inputField(
                      readOnly: false,
                      lable: 'Tischbezeichnung',
                      controller: _controller,
                      keyboardType: TextInputType.number)),
              SizedBox(width: 20.w),
              Expanded(
                  child: inputField(
                      isButtonVisible: true,
                      lable: 'Kapazität',
                      controller: TextEditingController(
                          text: "${db.tableCapacity} Personen"))),
            ],
          ),
          SizedBox(height: 660.h),
          BaseButton(
            buttonText: 'Bestätigen',
            onPressed: () {
              if (_controller.text == fixedText || db.tableCapacity == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Enter table number and capacity!')),
                );
              } else {
                db
                    .addTable(context: context, number: _controller.text)
                    .then((added) {
                  if (added == true) {
                    value.changeTable(true);
                    value.changeTableTitle("Tisch");
                  }
                });
              }
            },
          )
        ],
      );
    });
  }

  inputField(
      {required String lable,
      bool readOnly = true,
      Widget prefix = const SizedBox.shrink(),
      TextInputType? keyboardType,
      bool isButtonVisible = false,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lable,
            style: kMediumTextStyle.copyWith(
                color: AppColors.lightblack3, fontSize: 15.sp)),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Visibility(
              visible: isButtonVisible,
              child: SizedBox(
                height: 90.h,
                width: 20.w,
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          context.read<Database>().capacityIncrement();
                        },
                        child: Icon(Icons.keyboard_arrow_up)),
                    InkWell(
                        onTap: () {
                          context.read<Database>().capacityDecrement();
                        },
                        child: Icon(Icons.keyboard_arrow_down)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BaseTextField(
                prefix: prefix,
                isRead: readOnly,
                keyboardType: keyboardType,
                controller: controller,
                borderColor: Colors.black.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
