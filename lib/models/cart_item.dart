import 'package:hive/hive.dart';

part 'cart_item.g.dart'; // File ini akan digenerate otomatis nanti, biarkan error dulu

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  String username; // Sangat penting untuk memfilter keranjang tiap user

  @HiveField(1)
  int productId;

  @HiveField(2)
  String title;

  @HiveField(3)
  double price;

  @HiveField(4)
  String thumbnail;

  @HiveField(5)
  int qty;

  CartItem({
    required this.username,
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.qty,
  });
}
