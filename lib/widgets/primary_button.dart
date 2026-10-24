import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable full-width button with a cinematic glowing gradient and loading state.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 52.0,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isInteractive = !isLoading && onPressed != null;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: isInteractive
            ? const LinearGradient(
                colors: [Color(0xFFE50914), Color(0xFFFF3366)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isInteractive ? null : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isInteractive
            ? [
                BoxShadow(
                  color: const Color(0xFFE50914).withValues(alpha: 0.38),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isInteractive ? onPressed : null,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[icon!, const SizedBox(width: 8)],
                      Text(
                        text,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
