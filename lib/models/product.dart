class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final int stock;
  final String thumbnail; // Kita ambil thumbnail saja untuk gambar list/cart

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      // Konversi aman ke double
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}
