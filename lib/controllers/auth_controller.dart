import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString currentUsername = ''.obs;

  // Password wajib menggunakan NIM
  final String nimPassword = '123230066';

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {
      currentUsername.value = prefs.getString('username') ?? '';
    }
  }

  Future<bool> login(String username, String password) async {
    if (password == nimPassword && username.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);

      isLoggedIn.value = true;
      currentUsername.value = username;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus session
    isLoggedIn.value = false;
    currentUsername.value = '';

    // Arahkan kembali ke halaman Login (Route ini akan kita buat di Tahap 3)
    Get.offAllNamed('/login');
  }
}
