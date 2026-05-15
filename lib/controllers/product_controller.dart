import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List list = data['products'];
        products.value = list.map((e) => Product.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data produk dari API');
    } finally {
      isLoading.value = false;
    }
  }
}
