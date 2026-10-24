import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking_app/features/authentication/presentation/screens/loginscreen.dart';
import 'package:movie_booking_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:movie_booking_app/widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF090B10),
      body: Stack(
        children: [
          // Ambient neon glows with pulse animation
          Positioned(
            top: -70,
            right: -60,
            child:
                Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE50914).withValues(alpha: 0.35),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: const SizedBox(),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.15, 1.15),
                      duration: 3600.ms,
                    ),
          ),
          Positioned(
            top: size.height * 0.38,
            left: -80,
            child:
                Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6366F1).withValues(alpha: 0.22),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 110, sigmaY: 110),
                        child: const SizedBox(),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.2, 1.2),
                      duration: 4200.ms,
                    ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  // Top Brand Logo
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFE50914), Color(0xFFFF3366)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFE50914,
                                  ).withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.local_movies_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'CINEVERSE',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.8,
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.2, end: 0),

                  const Spacer(flex: 1),

                  // Centerpiece: VIP Movie Ticket Card
                  _buildTicketCard()
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 150.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.0, 1.0),
                      ),

                  const Spacer(flex: 1),

                  // Catchy Headline & Subtitle
                  Text(
                    'Experience Cinema\nLike Never Before',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 28,
                      height: 1.25,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
                  const SizedBox(height: 10),
                  Text(
                    'Book front-row blockbuster tickets, reserve best seats, and enjoy fast popcorn combos in one tap.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.grey[400],
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 250.ms),
                  const SizedBox(height: 20),

                  // Feature Badges Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBadge(Icons.bolt_rounded, 'Instant Seats'),
                      const SizedBox(width: 8),
                      _buildBadge(Icons.fastfood_rounded, 'Snack Perks'),
                      const SizedBox(width: 8),
                      _buildBadge(
                        Icons.confirmation_number_outlined,
                        'No Fees',
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

                  const SizedBox(height: 32),

                  // Primary Button (Get Started)
                  PrimaryButton(
                        text: 'Get Started',
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 350.ms)
                      .slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 12),

                  // Sign In Outlined Button
                  SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.22),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'I Already Have an Account',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

                  const SizedBox(height: 12),

                  // Guest Preview
                  Center(
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Exploring Cineverse as Guest...',
                              style: GoogleFonts.outfit(),
                            ),
                            backgroundColor: const Color(0xFF1E2235),
                          ),
                        );
                      },
                      child: Text(
                        'Continue as Guest',
                        style: GoogleFonts.outfit(
                          color: Colors.grey[500],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 450.ms),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard() {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1B1F30).withValues(alpha: 0.85),
              const Color(0xFF0F121E).withValues(alpha: 0.95),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: const Color(0xFFE50914).withValues(alpha: 0.18),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top tag & rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.stars_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'VIP PREMIERE',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '4.9',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Icon circle
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFE50914).withValues(alpha: 0.25),
                    const Color(0xFF6366F1).withValues(alpha: 0.35),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.confirmation_number_rounded,
                  size: 38,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'IMAX 3D Experience',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Dolby Atmos • Laser 4K • Prime Row D',
              style: GoogleFonts.outfit(
                color: Colors.grey[400],
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),

            // Dashed line
            Row(
              children: List.generate(
                22,
                (index) => Expanded(
                  child: Container(
                    height: 1.5,
                    color: index.isEven
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Info items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTicketInfo('HALL', 'Ultra 01'),
                _buildTicketInfo('SEAT', 'D-12, D-13'),
                _buildTicketInfo('TIME', '08:30 PM'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: Colors.grey[500],
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFFF5252), size: 14),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
