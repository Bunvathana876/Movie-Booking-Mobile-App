import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Clean, modern text input field with frosted borders and cinema styling.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      style: GoogleFonts.outfit(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: const Color(0xFFE50914),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 14,
        ),
        floatingLabelStyle: GoogleFonts.outfit(
          color: const Color(0xFFFF4D67),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.outfit(
          color: Colors.white.withValues(alpha: 0.25),
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 14, right: 10),
          child: Icon(
            prefixIcon,
            color: Colors.white.withValues(alpha: 0.7),
            size: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.04),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE50914), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF4D4D), width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF4D4D), width: 1.5),
        ),
        errorStyle: GoogleFonts.outfit(
          color: const Color(0xFFFF6B6B),
          fontSize: 12,
        ),
      ),
    );
  }
}
