# Toko KuBay - Latihan Responsi TPM

Aplikasi e-commerce sederhana yang dibangun menggunakan Flutter sebagai bagian dari Latihan Responsi mata kuliah Praktikum Teknologi dan Pemrograman Mobile (Prak. TPM). Aplikasi ini mengintegrasikan API eksternal, penyimpanan lokal (Hive & SharedPreferences), serta state management GetX.

## 🌟 Fitur Utama
- **Autentikasi & Sesi**: Login menggunakan Username (bebas) dan Password (NIM: 123230066). Sesi tersimpan menggunakan SharedPreferences sehingga mendukung fitur Auto-Login.
- **Katalog Produk**: Mengambil data produk secara real-time dari API Eksternal (https://dummyjson.com/products).
- **Detail Produk**: Menampilkan informasi lengkap produk beserta fitur manajemen kuantitas ($0 < qty \le totalQty$).
- **Keranjang Belanja (Multi-User)**: Data keranjang disimpan di database lokal Hive dan difilter berdasarkan username yang sedang login.
- **Profil Pengguna**: Menampilkan informasi akun dan fitur Logout untuk menghapus sesi.
- **UI Mewah**: Tema khusus "Toko KuBay" dengan nuansa cokelat mewah dan aksen amber.

## 🛠️ Library yang Digunakan
- **GetX**: Digunakan untuk State Management, Dependency Injection, dan Routing.
- **Hive & Hive Flutter**: Database NoSQL lokal untuk menyimpan data keranjang belanja secara persisten.
- **Shared Preferences**: Untuk manajemen sesi login (fitur Auto-Login).
- **Http**: Untuk melakukan request data ke API eksternal DummyJSON.

## 📁 Struktur Folder Proyek
Proyek ini diorganisir secara terstruktur untuk memisahkan logika bisnis dari antarmuka pengguna:

```text
lib/
├── controllers/                 # Logika bisnis dan State Management (GetX)
│   ├── auth_controller.dart     # Manajemen sesi & autentikasi pengguna
│   ├── cart_controller.dart     # Logika CRUD keranjang belanja (Hive)
│   └── product_controller.dart  # Fetching data dari API eksternal
├── models/                      # Definisi model data (POJO)
│   ├── cart_item.dart           # Model Hive untuk item di keranjang
│   ├── cart_item.g.dart         # Generated file oleh Hive (TypeAdapter)
│   └── product.dart             # Model untuk data produk dari API
├── views/                       # Kumpulan komponen antarmuka (UI)
│   └── pages/                   # Halaman-halaman utama aplikasi
│       ├── cart_page.dart       # Daftar produk dalam keranjang & total harga
│       ├── detail_page.dart     # Detail produk lengkap & fitur tambah qty
│       ├── home_page.dart       # Katalog produk & info login (Tab Home)
│       ├── login_page.dart      # Form autentikasi (Username & NIM)
│       ├── main_page.dart       # Wadah Bottom Navigation (Home & Profile)
│       └── profile_page.dart    # Informasi akun & tombol logout (Tab Profile)
└── main.dart                    # Titik masuk aplikasi & inisialisasi database/controller
```

## 🚀 Cara Menjalankan Aplikasi
**1. Pastikan Flutter SDK sudah terinstal di perangkat Anda.**
**2. Clone repository ini ke direktori lokal Anda.**
**3. Buka terminal dan jalankan perintah flutter pub get untuk menginstal dependencies.**
**4. Jalankan perintah flutter pub run build_runner build --delete-conflicting-outputs untuk men-generate file adapter Hive yang diperlukan.**
**5. Jalankan aplikasi menggunakan perintah flutter run atau melalui debugger IDE (VS Code/Android Studio).**

## 👤 Identitas Pengembang
Nama: Bayu Java Trenggana
NIM: 123230066
Kelas: Prak. TPM IF-C
