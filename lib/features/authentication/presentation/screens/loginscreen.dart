import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking_app/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:movie_booking_app/widgets/auth_header.dart';
import 'package:movie_booking_app/widgets/custom_text_field.dart';
import 'package:movie_booking_app/widgets/primary_button.dart';
import 'package:movie_booking_app/widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (email.isEmpty || password.isEmpty) return;

      debugPrint('Login attempt for $email');
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'Welcome back! Login successful.',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceAll('Exception: ', ''),
            style: GoogleFonts.outfit(),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: const Color(0xFF090B10),
      body: Stack(
        children: [
          // Ambient glowing orbs with subtle pulse animation
          Positioned(
            top: -60,
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
                      duration: 3500.ms,
                    ),
          ),
          Positioned(
            bottom: size.height * 0.2,
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

          SafeArea(
            child: Column(
              children: [
                // Top Navigation Bar
                Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (canPop)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            )
                          else
                            const SizedBox(width: 44),

                          // Brand Logo Pill
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE50914),
                                      Color(0xFFFF3366),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFE50914,
                                      ).withValues(alpha: 0.4),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.local_movies_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'CINEVERSE',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.2,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 44),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.2, end: 0),

                // Main Scrollable Area
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),

                        // Animated Header Icon
                        Center(
                              child: Container(
                                height: 72,
                                width: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE50914),
                                      Color(0xFFFF3366),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFE50914,
                                      ).withValues(alpha: 0.45),
                                      blurRadius: 22,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.confirmation_number_rounded,
                                    size: 34,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .scale(
                              begin: const Offset(0.7, 0.7),
                              end: const Offset(1.0, 1.0),
                            ),

                        const SizedBox(height: 20),

                        // Title & Subtitle
                        const AuthHeader(
                          title: 'Welcome Back',
                          subtitle:
                              'Sign in to access your digital tickets & exclusive VIP perks',
                        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

                        const SizedBox(height: 24),

                        // Mode Switcher Tab (Sign In / Sign Up)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFE50914),
                                        Color(0xFFFF3366),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFFE50914,
                                        ).withValues(alpha: 0.35),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Sign In',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.outfit(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 500.ms, delay: 150.ms),

                        const SizedBox(height: 24),

                        // Frosted Card Form
                        Container(
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF131722,
                                ).withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1.1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.45),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Email Field
                                    CustomTextField(
                                      controller: _emailController,
                                      label: 'Email Address',
                                      hintText: 'alex.cinema@example.com',
                                      prefixIcon: Icons.alternate_email_rounded,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        final regex = RegExp(
                                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                        );
                                        if (!regex.hasMatch(val.trim())) {
                                          return 'Enter a valid email address';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Password Field
                                    CustomTextField(
                                      controller: _passwordController,
                                      label: 'Password',
                                      hintText: 'Enter your password',
                                      prefixIcon: Icons.lock_outline_rounded,
                                      obscureText: !_isPasswordVisible,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) => _handleLogin(),
                                      suffixIcon: IconButton(
                                        onPressed: () => setState(
                                          () => _isPasswordVisible =
                                              !_isPasswordVisible,
                                        ),
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded,
                                          color: Colors.grey[400],
                                          size: 20,
                                        ),
                                      ),
                                      validator: (val) =>
                                          val == null || val.length < 6
                                          ? 'Minimum 6 characters'
                                          : null,
                                    ),
                                    const SizedBox(height: 12),

                                    // Remember Me & Forgot Password Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => setState(
                                            () => _rememberMe = !_rememberMe,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 22,
                                                height: 22,
                                                child: Checkbox(
                                                  value: _rememberMe,
                                                  activeColor: const Color(
                                                    0xFFE50914,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                  ),
                                                  side: BorderSide(
                                                    color: Colors.white
                                                        .withValues(
                                                          alpha: 0.35,
                                                        ),
                                                  ),
                                                  onChanged: (val) => setState(
                                                    () => _rememberMe =
                                                        val ?? false,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Remember me',
                                                style: GoogleFonts.outfit(
                                                  color: Colors.grey[400],
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Password reset instructions sent to your email.',
                                                  style: GoogleFonts.outfit(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: GoogleFonts.outfit(
                                              color: const Color(0xFFFF4D67),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),

                                    // Primary Sign In Button
                                    PrimaryButton(
                                      text: 'Sign In',
                                      icon: const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      onPressed: _handleLogin,
                                      isLoading: _isLoading,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 200.ms)
                            .slideY(begin: 0.1, end: 0),

                        const SizedBox(height: 26),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                'or continue with',
                                style: GoogleFonts.outfit(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms, delay: 250.ms),

                        const SizedBox(height: 20),

                        // Social Buttons (Google & Apple)
                        Row(
                          children: [
                            Expanded(
                              child: SocialAuthButton.google(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Google Sign-In initialized...',
                                        style: GoogleFonts.outfit(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: SocialAuthButton.apple(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Apple Sign-In initialized...',
                                        style: GoogleFonts.outfit(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

                        const SizedBox(height: 28),

                        // Bottom Navigation to Sign Up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.outfit(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.outfit(
                                  color: const Color(0xFFFF3366),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms, delay: 350.ms),

                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
