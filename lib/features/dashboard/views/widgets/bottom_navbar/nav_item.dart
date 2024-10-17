import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavItem extends StatelessWidget {
  final String itemName;
  final IconData icon;
  final bool isActive;
  final GestureTapCallback? onTap;
  const NavItem(
      {super.key,
      required this.icon,
      required this.itemName,
      required this.isActive,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: isActive ? Colors.blue.shade700 : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 25.0,
              color: isActive ? Colors.white : Colors.grey.shade600,
            ),
            // SizedBox(
            //   width: isActive ? 5.0 : 0,
            // ),
            // Text(
            //   isActive ? itemName : "",
            //   style: GoogleFonts.poppins(
            //       color: Colors.white,
            //       fontSize: 15.0,
            //       fontWeight: FontWeight.w500),
            // ),
          ],
        ),
      ),
    );
  }
}
