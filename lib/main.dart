import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking_app/features/authentication/presentation/screens/welcome_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF090B10),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFE50914);
    final darkTheme = ThemeData.dark();

    return MaterialApp(
      title: 'Cineverse Movie Booking',
      debugShowCheckedModeBanner: false,
      theme: darkTheme.copyWith(
        scaffoldBackgroundColor: const Color(0xFF090B10),
        textTheme: GoogleFonts.outfitTextTheme(darkTheme.textTheme),
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: Color(0xFFFF3366),
          surface: Color(0xFF131722),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
