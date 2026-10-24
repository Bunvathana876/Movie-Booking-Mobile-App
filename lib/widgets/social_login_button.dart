import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Clean, frosted glass social authentication button (e.g., Google, Apple).
class SocialAuthButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? customIcon;
  final Color? iconColor;
  final VoidCallback onPressed;
  final double height;

  const SocialAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.customIcon,
    this.iconColor,
    this.height = 50.0,
  });

  /// Factory constructor for a Google button with authentic logo
  factory SocialAuthButton.google({
    Key? key,
    required VoidCallback onPressed,
    String text = 'Google',
    double height = 50.0,
  }) {
    return SocialAuthButton(
      key: key,
      text: text,
      onPressed: onPressed,
      height: height,
      customIcon: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'G',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'sans-serif',
          ),
        ),
      ),
    );
  }

  /// Factory constructor for an Apple button with native Apple icon
  factory SocialAuthButton.apple({
    Key? key,
    required VoidCallback onPressed,
    String text = 'Apple',
    double height = 50.0,
  }) {
    return SocialAuthButton(
      key: key,
      text: text,
      onPressed: onPressed,
      height: height,
      icon: Icons.apple,
      iconColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF131722).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          splashColor: const Color(0xFFE50914).withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (customIcon != null)
                customIcon!
              else if (icon != null)
                Icon(icon, color: iconColor ?? Colors.white, size: 22),
              const SizedBox(width: 10),
              Text(
                text,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
