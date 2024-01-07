import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF5A5A5C),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      child:   TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search Malls or Branch',
          hintStyle: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
}