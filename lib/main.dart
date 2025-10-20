import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:tipicos_jholy/providers/cart_provider.dart';
import 'models/product.dart';
import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'screens/home_screen.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const TipicosJholyApp(),
    ),
  );
}

class TipicosJholyApp extends StatelessWidget {
  const TipicosJholyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Típicos Jholy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
