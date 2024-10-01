import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jahnhalle_provider/provider/bottom_navigation_provider.dart';
import 'package:jahnhalle_provider/screens/bottom_navigation/sub_screens/profile_content.dart';
import 'package:jahnhalle_provider/utils/common/base_button.dart';
import 'package:jahnhalle_provider/utils/widgets/base_appbar.dart';
import 'package:jahnhalle_provider/utils/widgets/base_home.dart';
import 'package:jahnhalle_provider/utils/widgets/home_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(builder: (context, value, child) {
      return BaseHome(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 38.h, horizontal: 28.w),
          child: Column(
            children: [
              BaseAppBar(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                title: value.homeTitle,
              ),
              if (value.isHome) ...[
                HomeTile(
                  title: 'Bestellungen',
                  subtitle: 'aktuelle Bestellungen',
                  onTap: () {
                    value.onItemTapped(6);
                    // value.changeTable(true);
                    // value.changeTableTitle("Tisch");
                  },
                  isActive: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Events',
                        subtitle: 'aktuelle Events + Planung',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Angebote',
                        subtitle: 'Drinks, Essen, etc',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Tische',
                        subtitle: 'erstellen und verwalten',
                        onTap: () {
                          value.onItemTapped(4);
                        },
                        isActive: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Menü',
                        subtitle: 'erstellen und verwalten',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Performance',
                        subtitle: 'Auswertung Dynamik',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Treuesystem',
                        subtitle: 'Kundenbindung stärken',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Rechnungen',
                        subtitle: 'Abschlüsse und Rechnugen',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Abholung',
                        subtitle: 'Abholservice ',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Expanded(
                      child: HomeTile(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        title: 'Kunden',
                        subtitle: 'Kundenkartei',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const ProfileContent(),
                BaseButton(
                  buttonText: 'Speichern',
                  onPressed: () {},
                )
              ],
            ],
          ),
        ),
      );
    });
  }
}
