import 'package:flutter/material.dart';

//Light Theme
final lightTheme = ThemeData(
  fontFamily: 'Cera Pro',
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.teal,),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(27),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
useMaterial3: true,
);

//Dark Theme
final darkTheme=ThemeData(
  fontFamily: 'Cera Pro',
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.teal, brightness: Brightness.dark,),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(27),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.teal,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  ),
useMaterial3: true,
);
