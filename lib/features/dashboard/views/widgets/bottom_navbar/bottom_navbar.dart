import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:junglee_news/resources/app_state_provider.dart';
import 'package:provider/provider.dart';

import 'nav_item.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<AppStateProvider>(
      builder: (context, item, child) {
        return Material(
          elevation: 25,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: screenHeight * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NavItem(
                  icon: Icons.home,
                  itemName: "Home",
                  isActive: item.getActiveDashboardIndex() == 0 ? true : false,
                  onTap: () {
                    item.setDashboardView(0);
                  },
                ),
                NavItem(
                  icon: Icons.view_headline,
                  itemName: "Shorts",
                  isActive: item.getActiveDashboardIndex() == 1 ? true : false,
                  onTap: () {
                    item.setDashboardView(1);
                  },
                ),
                NavItem(
                  icon: Icons.save_alt,
                  itemName: "Downloads",
                  isActive: item.getActiveDashboardIndex() == 2 ? true : false,
                  onTap: () {
                    item.setDashboardView(2);
                  },
                ),
                // NavItem(
                //   icon: Icons.person,
                //   itemName: "Profile",
                //   isActive: item.getActiveDashboardIndex() == 3 ? true : false,
                //   onTap: () {
                //     item.setDashboardView(3);
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
