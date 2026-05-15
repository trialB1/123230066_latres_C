import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/cart_item.dart';
import 'controllers/auth_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/cart_controller.dart';

import 'views/pages/login_page.dart';
import 'views/pages/main_page.dart';
import 'views/pages/detail_page.dart';
import 'views/pages/cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');

  final authC = Get.put(AuthController());
  await authC.checkLoginStatus();

  Get.put(ProductController());
  Get.put(CartController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko KuBay',
      theme: ThemeData(
        primaryColor: Colors.brown.shade800,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.brown.shade800,
          secondary: Colors.amber.shade700,
        ),
      ),

      // PERUBAHAN DI SINI: Gunakan 'home' alih-alih 'initialRoute'
      home: authC.isLoggedIn.value ? MainPage() : LoginPage(),

      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainPage()),
        GetPage(name: '/detail', page: () => DetailPage()),
        GetPage(name: '/cart', page: () => CartPage()),
      ],
    );
  }
}
