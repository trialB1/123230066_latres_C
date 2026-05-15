import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  late Box<CartItem> cartBox;
  final AuthController authC = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    cartBox = Hive.box<CartItem>('cartBox');
    loadCart();
  }

  void loadCart() {
    final currentUser = authC.currentUsername.value;
    // Poin G: Filter isi cart hanya untuk user yang sedang login
    final userCart = cartBox.values
        .where((item) => item.username == currentUser)
        .toList();
    cartItems.value = userCart;
  }

  void addToCart(Product product, int qty) {
    // Validasi 0 < qty <= totalQty (Poin f)
    if (qty <= 0 || qty > product.stock) {
      Get.snackbar('Gagal', 'Kuantitas tidak valid atau melebihi stok');
      return;
    }

    final currentUser = authC.currentUsername.value;
    int existingIndex = cartItems.indexWhere(
      (item) => item.productId == product.id,
    );

    if (existingIndex != -1) {
      // Jika produk sudah ada di keranjang, tambah kuantitasnya
      CartItem item = cartItems[existingIndex];
      if (item.qty + qty <= product.stock) {
        item.qty += qty;
        item.save(); // Method bawaan HiveObject untuk update data
        Get.snackbar('Berhasil', 'Kuantitas diperbarui di keranjang');
      } else {
        Get.snackbar(
          'Gagal',
          'Total kuantitas di keranjang melebihi stok yang tersedia',
        );
      }
    } else {
      // Jika belum ada, buat entry baru di database lokal
      final newItem = CartItem(
        username: currentUser,
        productId: product.id,
        title: product.title,
        price: product.price,
        thumbnail: product.thumbnail,
        qty: qty,
      );
      cartBox.add(newItem);
      Get.snackbar('Berhasil', '${product.title} ditambahkan ke keranjang');
    }
    loadCart(); // Refresh state UI
  }

  void removeFromCart(CartItem item) {
    item.delete(); // Method bawaan HiveObject untuk menghapus dari database
    loadCart(); // Refresh state UI
    Get.snackbar('Dihapus', 'Item dihapus dari keranjang');
  }

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.qty));
  }
}
