import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextField(
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.grey[600],
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: "Filter by username...",
          hintStyle: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.grey[400],
          ),
        ),
        controller: controller,
      ),
    );
  }
}
