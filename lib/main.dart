import 'package:flutter/material.dart';
import 'package:gadgetgalaxyfe/pages/cart/checkout_screen.dart';
import 'package:gadgetgalaxyfe/pages/compare/compare_screen.dart';
import 'package:gadgetgalaxyfe/pages/home/home_screen.dart';
import 'package:gadgetgalaxyfe/pages/order/order_screen.dart';
import 'package:gadgetgalaxyfe/pages/profile/profile_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const VoltaApp());
}

class VoltaApp extends StatelessWidget {
  const VoltaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VOLTA',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/compare': (context) => const CompareScreen(),
        '/checkout': (context) => const CheckoutScreen(),
      },
    );
  }
}