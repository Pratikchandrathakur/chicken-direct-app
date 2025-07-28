import 'package:flutter/material.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/checkout_screen/checkout_screen.dart';
import '../presentation/shopping_cart_screen/shopping_cart_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String loginScreen = '/login-screen';
  static const String registrationScreen = '/registration-screen';
  static const String productDetailScreen = '/product-detail-screen';
  static const String homeScreen = '/home-screen';
  static const String checkoutScreen = '/checkout-screen';
  static const String shoppingCartScreen = '/shopping-cart-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => HomeScreen(),
    loginScreen: (context) => LoginScreen(),
    registrationScreen: (context) => RegistrationScreen(),
    productDetailScreen: (context) => ProductDetailScreen(),
    homeScreen: (context) => HomeScreen(),
    checkoutScreen: (context) => CheckoutScreen(),
    shoppingCartScreen: (context) => ShoppingCartScreen(),
    // TODO: Add your other routes here
  };
}
