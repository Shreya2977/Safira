// 📍 lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/contact_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeJourney',
      theme: ThemeData(
        // Modern way - using ColorScheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF6C63FF),
          primary: Color(0xFF6C63FF), // Purple
          secondary: Color(0xFFFF6584), // Pink (replaces accentColor)
          error: Colors.red, // For error states
          background: Colors.white, // Background color
        ),

        // You can still set scaffold background separately
        scaffoldBackgroundColor: Colors.white,

        // App bar theme
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),

        // Text theme
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
          ),
        ),

        // Font
        fontFamily: 'Roboto',
      ),

      // For material 3 design (optional)
      // useMaterial3: true,

      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/contacts': (context) => ContactsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
