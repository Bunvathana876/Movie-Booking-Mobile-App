import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking_app/features/authentication/presentation/screens/loginscreen.dart';
import 'package:movie_booking_app/widgets/auth_header.dart';
import 'package:movie_booking_app/widgets/custom_text_field.dart';
import 'package:movie_booking_app/widgets/primary_button.dart';
import 'package:movie_booking_app/widgets/social_login_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMinLength => _passwordController.text.length >= 6;
  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_passwordController.text);
  bool get _hasSpecialOrUpper =>
      RegExp(r'[A-Z]').hasMatch(_passwordController.text) ||
      RegExp(r'[^A-Za-z0-9]').hasMatch(_passwordController.text);

  int get _passwordScore {
    int score = 0;
    if (_hasMinLength) score++;
    if (_hasNumber) score++;
    if (_hasSpecialOrUpper) score++;
    return score;
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms of Service & Privacy Policy.',
            style: GoogleFonts.outfit(),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();

      debugPrint('Registering user: $name ($email)');
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Welcome to Cineverse, $name! Your account has been created.',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
                ),
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

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
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

    return Scaffold(
      backgroundColor: const Color(0xFF090B10),
      body: Stack(
        children: [
          // Ambient Glows with subtle pulse
          Positioned(
            top: -60,
            left: -60,
            child:
                Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE50914).withValues(alpha: 0.32),
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
                      duration: 3800.ms,
                    ),
          ),
          Positioned(
            bottom: size.height * 0.15,
            right: -80,
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
                      end: const Offset(1.18, 1.18),
                      duration: 4400.ms,
                    ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              onPressed: () => Navigator.of(context).maybePop(),
                            ),
                          ),
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

                // Scrollable Form
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

                        // Title Header
                        const AuthHeader(
                          title: 'Create Account',
                          subtitle:
                              'Join Cineverse to unlock front-row seats & exclusive VIP benefits',
                        ).animate().fadeIn(duration: 500.ms),

                        const SizedBox(height: 22),

                        // Tab Switcher (Sign In vs Sign Up)
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
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Sign In',
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
                                    'Sign Up',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

                        const SizedBox(height: 24),

                        // Frosted Form Card
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
                                    // Full Name
                                    CustomTextField(
                                      controller: _nameController,
                                      label: 'Full Name',
                                      hintText: 'John Doe',
                                      prefixIcon: Icons.person_outline_rounded,
                                      textInputAction: TextInputAction.next,
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return 'Please enter your full name';
                                        }
                                        if (val.trim().length < 2) {
                                          return 'Name must be at least 2 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Email
                                    CustomTextField(
                                      controller: _emailController,
                                      label: 'Email Address',
                                      hintText: 'alex.cinema@example.com',
                                      prefixIcon: Icons.alternate_email_rounded,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return 'Email is required';
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

                                    // Phone Number
                                    CustomTextField(
                                      controller: _phoneController,
                                      label: 'Phone Number (Optional)',
                                      hintText: '+1 234 567 8900',
                                      prefixIcon: Icons.phone_outlined,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    const SizedBox(height: 16),

                                    // Password
                                    CustomTextField(
                                      controller: _passwordController,
                                      label: 'Password',
                                      hintText: 'At least 6 characters',
                                      prefixIcon: Icons.lock_outline_rounded,
                                      obscureText: !_isPasswordVisible,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (_) => setState(() {}),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded,
                                          color: Colors.grey[400],
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Password is required';
                                        }
                                        if (val.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),

                                    // Interactive password strength meter with checklist
                                    if (_passwordController
                                        .text
                                        .isNotEmpty) ...[
                                      const SizedBox(height: 10),
                                      _buildInteractiveStrengthSection(),
                                    ],

                                    const SizedBox(height: 16),

                                    // Confirm Password
                                    CustomTextField(
                                      controller: _confirmPasswordController,
                                      label: 'Confirm Password',
                                      hintText: 'Re-enter your password',
                                      prefixIcon: Icons.verified_user_outlined,
                                      obscureText: !_isConfirmPasswordVisible,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) => _handleSignUp(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isConfirmPasswordVisible
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded,
                                          color: Colors.grey[400],
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isConfirmPasswordVisible =
                                                !_isConfirmPasswordVisible;
                                          });
                                        },
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please confirm your password';
                                        }
                                        if (val != _passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Terms and Conditions Checkbox
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _agreeToTerms = !_agreeToTerms;
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: Checkbox(
                                              value: _agreeToTerms,
                                              activeColor: const Color(
                                                0xFFE50914,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white.withValues(
                                                  alpha: 0.35,
                                                ),
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  _agreeToTerms = val ?? false;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                text: 'I agree to the ',
                                                style: GoogleFonts.outfit(
                                                  color: Colors.grey[400],
                                                  fontSize: 12,
                                                ),
                                                children: const [
                                                  TextSpan(
                                                    text: 'Terms of Service',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  TextSpan(text: ' & '),
                                                  TextSpan(
                                                    text: 'Privacy Policy',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    // Submit Primary Button
                                    PrimaryButton(
                                      text: 'Create Account',
                                      isLoading: _isLoading,
                                      onPressed: _handleSignUp,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 180.ms)
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
                                'or sign up with',
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
                        ).animate().fadeIn(duration: 500.ms, delay: 240.ms),

                        const SizedBox(height: 20),

                        // Social Sign-up (Google & Apple)
                        Row(
                          children: [
                            Expanded(
                              child: SocialAuthButton.google(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Google Sign-Up tapped...',
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
                                        'Apple Sign-Up tapped...',
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

                        // Bottom Navigation to Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: GoogleFonts.outfit(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.outfit(
                                  color: const Color(0xFFFF3366),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 500.ms, delay: 360.ms),

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

  Widget _buildInteractiveStrengthSection() {
    Color color;
    String label;
    double progress;

    switch (_passwordScore) {
      case 1:
        color = const Color(0xFFFF4D4D);
        label = 'Weak';
        progress = 0.33;
        break;
      case 2:
        color = Colors.amber;
        label = 'Moderate';
        progress = 0.66;
        break;
      case 3:
        color = const Color(0xFF10B981);
        label = 'Strong';
        progress = 1.0;
        break;
      default:
        color = Colors.grey;
        label = 'Too short';
        progress = 0.1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password strength',
              style: GoogleFonts.outfit(color: Colors.grey[400], fontSize: 11),
            ),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            _buildCriteriaPill('6+ characters', _hasMinLength),
            _buildCriteriaPill('Number', _hasNumber),
            _buildCriteriaPill('Upper/Symbol', _hasSpecialOrUpper),
          ],
        ),
      ],
    );
  }

  Widget _buildCriteriaPill(String title, bool isMet) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isMet
            ? const Color(0xFF10B981).withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMet
              ? const Color(0xFF10B981).withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: 11,
            color: isMet ? const Color(0xFF10B981) : Colors.grey[500],
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: GoogleFonts.outfit(
              color: isMet ? Colors.white : Colors.grey[500],
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
