import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kayon_frontend/pages/landing.dart';
import 'package:upgrader/upgrader.dart';


void main() async {
    // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kazyon market',
      theme: ThemeData(
         fontFamily: 'Lexend',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.lexendTextTheme(),
                visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      
 builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
            home:
              Landing(title: 'kazyon market'),
    );
  }
}


