import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://eelyofbfahzunrnbhntq.supabase.co',
    publishableKey:
    'sb_publishable__vXDxRadJ7stY9S8VQmGJw_4VylJ6Js',
  );

  runApp(const GroceryShoppingApp());
}

class GroceryShoppingApp extends StatelessWidget {
  const GroceryShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Shopping App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B8E62),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}