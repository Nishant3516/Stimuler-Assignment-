import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  brightness:
      Brightness.dark, // Dark theme overall, but with customized text theme
  scaffoldBackgroundColor: Colors.black, // Set scaffold background to black
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey[350], // Light greyish text color
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey[400], // Slightly lighter greyish text color
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey[400], // Slightly lighter greyish text color
    ),
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black, // Black text for headlines
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.grey[300], // Lighter grey for subtitles
    ),
    displaySmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.grey[400],
    ),
  ),
);
