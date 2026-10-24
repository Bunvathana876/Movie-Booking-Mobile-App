import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Clean, cinematic header for authentication screens with typography.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? logo;
  final TextAlign textAlign;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.logo,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final isLeft = textAlign == TextAlign.left;

    return Column(
      crossAxisAlignment: isLeft
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        if (logo != null) ...[logo!, const SizedBox(height: 18)],
        Text(
          title,
          textAlign: textAlign,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: textAlign,
          style: GoogleFonts.outfit(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
