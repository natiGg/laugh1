import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/constants/constants.dart';

Widget makeCategory({isActive, title}) {
  return AspectRatio(
    aspectRatio: isActive ? 2.5 : 1.5 / 1,
    child: Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: isActive ? Constants.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Align(
        child: Text(
          title,
          style: GoogleFonts.poppins(
              color: isActive ? Colors.white : Constants.primaryColor,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w400),
        ),
      ),
    ),
  );
}
