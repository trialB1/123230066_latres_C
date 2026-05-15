import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthController authC = Get.find<AuthController>();
  final ProductController prodC = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Hai, ${authC.currentUsername.value}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.brown.shade800,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ],
      ),
      body: Obx(() {
        if (prodC.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Colors.brown.shade800),
          );
        }
        return ListView.builder(
          itemCount: prodC.products.length,
          itemBuilder: (context, index) {
            final product = prodC.products[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.thumbnail,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  product.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '\$${product.price} | Stok: ${product.stock}',
                  style: TextStyle(color: Colors.brown.shade700),
                ),
                onTap: () => Get.toNamed('/detail', arguments: product),
              ),
            );
          },
        );
      }),
    );
  }
}
