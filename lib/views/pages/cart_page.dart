import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartController cartC = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    cartC.loadCart();

    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown.shade800,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (cartC.cartItems.isEmpty) {
          return Center(
            child: Text(
              'Keranjang Anda kosong.',
              style: TextStyle(color: Colors.brown.shade700),
            ),
          );
        }
        return ListView.builder(
          itemCount: cartC.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartC.cartItems[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.thumbnail,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '\$${item.price} x ${item.qty}',
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => cartC.removeFromCart(item),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade900,
                ),
              ),
              Text(
                '\$${cartC.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
