Berikut versi lengkapnya dalam format **Markdown (README.md)** siap pakai 👇

---

````md
# 🧊 Cold Storage Warehouse Management

Mini Flutter App untuk memonitor suhu **cold rooms**, mengelola **inbound barang**, dan melihat **inventory**.  
Proyek ini dikembangkan dengan arsitektur **Clean Architecture + Cubit (BLoC)**, menggunakan **mock API polling** untuk menampilkan suhu “real-time”.

---

## 🚀 Cara Menjalankan Aplikasi

### 1️⃣ Clone Repository
```bash
git clone https://github.com/username/cold_storage_warehouse_management.git
cd cold_storage_warehouse_management
````

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Jalankan Mock API (Opsional)

Mock API disimulasikan secara lokal tanpa server eksternal.

* Suhu (`TemperatureCubit`) melakukan **polling setiap 5 detik** dari mock data:

  ```dart
  // contoh pseudo di repository
  Future<List<TemperatureModel>> fetchTemperatures() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      TemperatureModel(roomId: 'COLD-01', value: -21.0),
      TemperatureModel(roomId: 'COLD-02', value: -19.0),
      TemperatureModel(roomId: 'COLD-03', value: -15.5),
    ];
  }
  ```

* Tidak perlu menjalankan API server eksternal — data di-*mock* di layer data.

### 4️⃣ Jalankan Aplikasi

```bash
flutter run
```

---

## 🧱 Arsitektur Proyek

Proyek ini menggunakan pendekatan **Clean Architecture** dengan tiga lapisan utama:

```
lib/
└── features/
    ├── dashboard/
    │   ├── data/
    │   │   └── models/
    │   ├── domain/
    │   │   ├── entities/
    │   │   └── repositories/
    │   └── presentation/
    │       ├── cubit/
    │       ├── widgets/
    │       └── views/
    ├── inbound/
    └── inventory/
```

### 📘 Layer Penjelasan

| Layer            | Tanggung Jawab                                           | Contoh                                     |
| ---------------- | -------------------------------------------------------- | ------------------------------------------ |
| **Domain**       | Logika bisnis murni, bebas dari framework.               | `GetLocationsUseCase`, `InboundItemEntity` |
| **Data**         | Mengambil data dari sumber eksternal (API, mock, lokal). | `TemperatureRepositoryImpl`                |
| **Presentation** | UI, State Management, dan View Logic.                    | `TemperatureCubit`, `DashboardScreen`      |

---

## 🧠 State Management

Menggunakan **Cubit (flutter_bloc)** untuk alasan berikut:

| Alasan                  | Penjelasan                                                               |
| ----------------------- | ------------------------------------------------------------------------ |
| 🔹 Simpel & Lightweight | Cubit lebih ringan dibanding BLoC penuh, cocok untuk app kecil–menengah. |
| 🔹 Terpisah dari UI     | Memisahkan logic dari widget → memudahkan testing dan maintainability.   |
| 🔹 Reactive             | Cocok dengan use case *polling* “real-time temperature”.                 |

### Polling Logic

Polling dilakukan di `TemperatureCubit.startPolling()` dengan interval 5 detik:

```dart
void startPolling() {
  _timer = Timer.periodic(const Duration(seconds: 5), (_) => fetch());
}
```

Polling dihentikan otomatis di `dispose()`:

```dart
@override
void dispose() {
  stopPolling();
  super.dispose();
}
```

---

## ⚙️ Navigasi

Navigasi menggunakan **GoRouter**, dengan 3 layar utama:

1. `/dashboard` – Menampilkan suhu cold room (real-time).
2. `/inbound` – Form input inbound item dan lokasi penyimpanan.
3. `/inventory` – Daftar inventory saat ini.

Setiap halaman memiliki `BlocProvider` lokal via GoRoute:

```dart
GoRoute(
  path: '/dashboard',
  builder: (context, state) => BlocProvider(
    create: (_) => getIt<TemperatureCubit>(),
    child: const DashboardScreen(),
  ),
),
```

---

## 📋 Daftar Asumsi & Trade-Off

| Aspek                       | Penjelasan                                                                                                                                      |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| 🔸 **Data Source**          | Menggunakan mock data di repository karena tidak ada backend nyata.                                                                             |
| 🔸 **Polling vs Stream**    | Menggunakan polling (interval 5 detik) karena mock API, bukan socket real-time.                                                                 |
| 🔸 **State Management**     | Dipilih Cubit (bukan Provider atau Riverpod) karena lebih mudah diintegrasikan dengan Clean Architecture dan dependency injection (injectable). |
| 🔸 **Dependency Injection** | Menggunakan `injectable` + `get_it` agar scalable untuk penambahan feature baru.                                                                |
| 🔸 **UI Layout**            | Fokus pada fungsionalitas, bukan desain akhir. Styling dibuat minimalis.                                                                        |
| 🔸 **Error Handling**       | Disederhanakan (basic try-catch), tanpa toast/snackbar.                                                                                         |

---

## 🧩 Teknologi Utama

| Teknologi               | Fungsi                      |
| ----------------------- | --------------------------- |
| 🐦 Flutter 3.x          | Framework utama             |
| 💡 Cubit (flutter_bloc) | State management            |
| 🧩 Injectable + GetIt   | Dependency Injection        |
| 🧭 GoRouter             | Navigasi antar halaman      |
| 🕒 Timer (dart:async)   | Polling “real-time” suhu    |
| 📅 intl                 | Format tanggal waktu update |

---

## 🖼️ Screenshot (Opsional)

| Dashboard                                | Inbound                              | Inventory                                |
| ---------------------------------------- | ------------------------------------ | ---------------------------------------- |
| ![Dashboard](docs/screens/dashboard.png) | ![Inbound](docs/screens/inbound.png) | ![Inventory](docs/screens/inventory.png) |

---

## 👨‍💻 Author

**Nicholaus Adit**
Frontend & Flutter Developer

```

