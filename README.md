# MyPortfolio Mobile

Aplikasi portfolio pribadi berbasis Flutter yang digunakan untuk menampilkan identitas pemilik aplikasi dan mengelola daftar proyek secara interaktif. Aplikasi ini dikembangkan sebagai bagian dari pembelajaran Flutter dan implementasi konsep widget, navigasi, state management sederhana, serta operasi CRUD (*Create, Read, Update, Delete*).

## Identitas
Nama = Naila Salsabila 
NPM = 2506620702 
Kelas = C 
Platform = Flutter
Bahasa Pemrograman = Dart

## Deskripsi Proyek

MyPortfolio Mobile merupakan aplikasi portfolio sederhana yang memungkinkan pengguna melihat informasi pemilik aplikasi dan mengelola informasi proyek melalui antarmuka yang mudah digunakan.

Aplikasi ini memiliki halaman utama yang menampilkan identitas  dan beberapa menu navigasi. Pengguna dapat melihat daftar proyek, menambahkan proyek baru, melihat detail proyek, mengedit informasi proyek, serta menghapus proyek dengan konfirmasi.

## Fitur Aplikasi

1. **Halaman Utama**  
   Menampilkan informasi NPM, nama, kelas, serta menu navigasi aplikasi.

2. **Lihat Proyek (Read)**  
   Menampilkan daftar proyek yang tersedia beserta kategori masing-masing proyek.

3. **Tambah Proyek (Create)**  
   Memungkinkan pengguna menambahkan proyek dengan mengisi nama, kategori, dan deskripsi proyek.

4. **Detail Proyek**  
   Menampilkan informasi proyek secara lebih lengkap.

5. **Edit Proyek (Update)**  
   Memungkinkan pengguna mengubah nama, kategori, dan deskripsi proyek yang sudah tersedia.

6. **Hapus Proyek (Delete)**  
   Memungkinkan pengguna menghapus proyek melalui dialog konfirmasi agar penghapusan tidak dilakukan secara tidak sengaja.

7. **Validasi Form**  
   Memastikan kolom nama dan deskripsi proyek tidak kosong sebelum data disimpan.

## Teknologi yang Digunakan

- **Flutter** sebagai framework pengembangan aplikasi.
- **Dart** sebagai bahasa pemrograman.
- **Material Design** sebagai dasar komponen antarmuka.
- **Visual Studio Code** sebagai code editor.
- **Google Chrome** sebagai platform pengujian aplikasi.
- **Git dan GitHub** untuk version control dan penyimpanan kode proyek.

### Cara Menjalankan Proyek

1. Clone repositori GitHub:

```bash
git clone https://github.com/nel0ou/myportofolio_mobile.git
```

2. Masuk ke folder proyek:

```bash
cd myportofolio_mobile
```

3. Instal dependensi:

```bash
flutter pub get
```

4. Periksa kode untuk memastikan tidak terdapat masalah:

```bash
flutter analyze
```

5. Jalankan aplikasi melalui Google Chrome:

```bash
flutter run -d chrome
```

## Dokumentasi Penggunaan Aplikasi

### 1. Halaman Utama

Halaman utama menampilkan identitas pengembang berupa NPM, nama, dan kelas. Terdapat tiga menu utama, yaitu Lihat Proyek, Tambah Proyek, dan Logout.

### 2. Menambahkan Proyek

Pengguna memilih menu Tambah Proyek, kemudian mengisi nama proyek, kategori, dan deskripsi. Setelah tombol Simpan Proyek ditekan, data baru akan ditambahkan ke daftar proyek.

### 3. Melihat Daftar dan Detail Proyek

Pengguna memilih menu Lihat Proyek untuk melihat seluruh proyek yang tersedia. Setiap proyek dapat dipilih untuk membuka halaman detail.

### 4. Mengedit Proyek

Pada halaman detail, pengguna dapat memilih tombol Edit. Formulir akan menampilkan data proyek sebelumnya sehingga pengguna dapat mengubah informasi yang diperlukan. Setelah disimpan, informasi proyek diperbarui.

### 5. Menghapus Proyek

Pengguna memilih tombol Hapus pada halaman detail. Aplikasi akan menampilkan dialog konfirmasi. Proyek hanya dihapus apabila pengguna menyetujui konfirmasi tersebut.

## Penyimpanan Data

Pada versi saat ini, data proyek disimpan sementara menggunakan `List<Project>` di dalam aplikasi. Pengelolaan data dilakukan menggunakan `setState()` untuk memperbarui tampilan ketika terjadi perubahan.

Aplikasi belum menggunakan database atau penyimpanan permanen. Oleh karena itu, data proyek yang ditambahkan atau diubah akan kembali ke data awal ketika aplikasi dimulai ulang.

# Pertanyaan Reflektif

## Tugas 7

### 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Widget tree adalah struktur hierarki yang menggambarkan susunan widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai anaknya sehingga membentuk hubungan parent-child.

Widget parent berfungsi sebagai wadah atau pengatur widget child. Sementara itu, widget child merupakan komponen yang berada di dalam widget parent.

Contohnya pada proyek MyPortfolio Mobile, `MaterialApp` menjadi widget utama yang memiliki `MyHomePage` sebagai halaman awal. Di dalam `MyHomePage` terdapat `Scaffold` yang memiliki `AppBar` dan `body`. Bagian body dapat berisi `SingleChildScrollView`, `Column`, `Row`, `InfoCard`, dan widget lainnya.

Hubungan tersebut memungkinkan Flutter menyusun tampilan secara terstruktur dan mengatur bagaimana setiap komponen ditampilkan.

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

Berikut widget utama yang digunakan dalam proyek MyPortfolio Mobile:

| Widget | Fungsi |
|---|---|
| `MaterialApp` | Mengatur konfigurasi utama aplikasi, seperti tema dan halaman awal. |
| `Scaffold` | Menyediakan struktur dasar halaman aplikasi. |
| `AppBar` | Menampilkan bagian header atau judul halaman. |
| `Text` | Menampilkan tulisan atau informasi. |
| `Icon` | Menampilkan ikon. |
| `IconButton` | Menampilkan tombol berbentuk ikon. |
| `Column` | Menyusun widget secara vertikal. |
| `Row` | Menyusun widget secara horizontal. |
| `Expanded` | Membagi ruang yang tersedia pada Row atau Column. |
| `Center` | Menempatkan widget di tengah. |
| `Padding` | Memberikan jarak di sekitar widget. |
| `SizedBox` | Memberikan jarak atau ukuran tertentu. |
| `Card` | Menampilkan informasi dalam bentuk kartu. |
| `Material` | Memberikan tampilan berbasis Material Design. |
| `InkWell` | Memberikan respons ketika komponen ditekan. |
| `SingleChildScrollView` | Memungkinkan halaman digulir. |
| `GridView.count` | Menampilkan widget dalam susunan grid. |
| `ListView.builder` | Menampilkan daftar widget secara dinamis. |
| `ListTile` | Menyediakan susunan komponen daftar. |
| `Divider` | Memberikan garis pemisah. |
| `Form` | Mengelompokkan input dan proses validasi formulir. |
| `TextFormField` | Menyediakan kolom input teks dengan validasi. |
| `InputDecoration` | Mengatur label, ikon, dan tampilan kolom input. |
| `OutlineInputBorder` | Memberikan garis tepi pada kolom input. |
| `DropdownButtonFormField` | Menyediakan pilihan kategori dalam bentuk dropdown. |
| `DropdownMenuItem` | Menentukan pilihan pada dropdown. |
| `ElevatedButton` | Menyediakan tombol aksi. |
| `ElevatedButton.icon` | Menyediakan tombol aksi yang disertai ikon. |
| `TextButton` | Menyediakan tombol berbasis teks. |
| `AlertDialog` | Menampilkan dialog konfirmasi sebelum penghapusan. |
| `SnackBar` | Menampilkan notifikasi singkat kepada pengguna. |
| `NeverScrollableScrollPhysics` | Menonaktifkan scroll pada GridView agar mengikuti scroll halaman induk. |
| `MaterialPageRoute` | Menentukan transisi dan rute halaman ketika navigasi dilakukan. |

Selain widget bawaan Flutter, proyek ini juga memiliki beberapa widget atau class buatan sendiri, yaitu:

- `MyHomePage`: Mengatur halaman utama aplikasi.
- `InfoCard`: Menampilkan informasi identitas pengembang.
- `ItemCard`: Menampilkan tombol menu utama.
- `ProjectListPage`: Menampilkan daftar proyek.
- `AddProjectPage`: Menampilkan formulir untuk menambahkan proyek.
- `EditProjectPage`: Menampilkan formulir untuk mengubah proyek.
- `ProjectDetailPage`: Menampilkan informasi detail proyek.

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

`MaterialApp` merupakan widget yang digunakan untuk mengatur konfigurasi utama aplikasi Flutter dengan konsep Material Design.

Beberapa fungsi `MaterialApp` adalah:

1. Mengatur tema aplikasi melalui properti `theme`.
2. Menentukan halaman awal aplikasi melalui properti `home`.
3. Mengatur navigasi dan rute halaman.
4. Menyediakan konfigurasi dasar untuk tampilan aplikasi.
5. Mengatur judul aplikasi melalui properti `title`.

Pada proyek ini, `MaterialApp` digunakan di dalam `main.dart` sebagai root widget dengan `MyHomePage` sebagai halaman awal.

`MaterialApp` umumnya digunakan sebagai root widget karena menyediakan konfigurasi dasar yang dibutuhkan oleh halaman-halaman aplikasi. Dengan begitu, widget di dalamnya dapat menggunakan tema, navigasi, dan komponen Material Design secara konsisten.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

`StatelessWidget` dan `StatefulWidget` merupakan dua jenis widget dalam Flutter yang memiliki perbedaan dalam pengelolaan perubahan data.

**StatelessWidget**

StatelessWidget adalah widget yang tampilannya tidak bergantung pada perubahan state internal. Widget ini cocok digunakan ketika informasi yang ditampilkan tidak perlu diperbarui melalui perubahan state.

Contoh pada proyek ini:
- `InfoCard`, untuk menampilkan informasi identitas.
- `ItemCard`, untuk menampilkan tombol menu.

**StatefulWidget**

StatefulWidget adalah widget yang memiliki state atau kondisi yang dapat berubah selama aplikasi berjalan. Perubahan state dapat dilakukan menggunakan `setState()` sehingga Flutter membangun ulang bagian tampilan yang terpengaruh.

Contoh pada proyek ini:
- `MyHomePage`, karena mengelola daftar proyek.
- `ProjectListPage`, karena tampilan daftar proyek dapat berubah ketika proyek ditambah atau dihapus.
- `AddProjectPage`, karena mengelola input dan pilihan kategori.
- `EditProjectPage`, karena mengelola perubahan informasi proyek.
- `ProjectDetailPage`, karena informasi detail dapat berubah setelah proses edit.

Dengan demikian, StatelessWidget sebaiknya digunakan untuk komponen yang tampilannya relatif tetap, sedangkan StatefulWidget digunakan ketika tampilan perlu merespons perubahan data atau interaksi pengguna.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

`BuildContext` adalah objek yang menunjukkan posisi suatu widget di dalam widget tree Flutter.

BuildContext penting karena digunakan untuk mengakses informasi dan layanan yang tersedia dari widget parent atau lingkungan widget, seperti tema aplikasi, navigasi, dan ukuran layar.

Pada proyek MyPortfolio Mobile, BuildContext digunakan dalam beberapa bagian, contohnya:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text("MyPortfolio"),
    ),
  );
}
```

Pada contoh tersebut, `context` digunakan untuk mengakses tema aplikasi melalui `Theme.of(context)` sehingga warna AppBar mengikuti tema yang telah ditentukan.

BuildContext juga digunakan dalam navigasi, misalnya melalui `Navigator.push(context, ...)` untuk membuka halaman baru dan `Navigator.pop(context)` untuk kembali ke halaman sebelumnya.

### 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

**Hot reload** merupakan fitur Flutter yang memungkinkan perubahan kode diterapkan ke aplikasi yang sedang berjalan tanpa harus memulai ulang seluruh aplikasi. Fitur ini membantu proses pengembangan karena perubahan tampilan dan kode dapat dilihat dengan lebih cepat.

**Hot restart** merupakan proses memulai ulang aplikasi Flutter dari awal dengan tetap mempertahankan sesi proses pengembangan. Berbeda dengan hot reload, hot restart akan menginisialisasi ulang state aplikasi.

Perbedaannya adalah:

| Hot Reload | Hot Restart |
|---|---|
| Menerapkan perubahan kode dengan cepat. | Memulai ulang aplikasi dari awal. |
| Umumnya mempertahankan state yang sedang berjalan. | Mengatur ulang state aplikasi. |
| Cocok untuk perubahan tampilan dan logika tertentu. | Cocok untuk perubahan yang membutuhkan inisialisasi ulang state. |

Hot reload biasanya cukup digunakan ketika melakukan perubahan pada tampilan, teks, warna, atau sebagian logika aplikasi.

Namun, hot restart diperlukan ketika perubahan tidak diterapkan dengan benar melalui hot reload, misalnya ketika mengubah proses inisialisasi aplikasi atau nilai awal state.

Sementara itu, full restart diperlukan dalam kondisi tertentu, seperti ketika terdapat perubahan konfigurasi native atau perubahan pada dependensi yang membutuhkan proses build ulang.

Dalam proyek MyPortfolio Mobile, hot reload dapat membantu melihat perubahan tampilan dan fitur dengan cepat, sedangkan hot restart digunakan ketika aplikasi perlu memulai ulang state agar perubahan dapat diterapkan dengan benar.

---

## Kesimpulan

Melalui pengembangan MyPortfolio Mobile, saya mempelajari dasar pengembangan aplikasi Flutter, mulai dari memahami widget tree, menggunakan widget bawaan dan widget buatan sendiri, mengelola state, melakukan navigasi antarhalaman, hingga mengimplementasikan fitur CRUD.

Saya juga memahami bahwa dokumentasi, pengujian, dan penggunaan AI secara kritis merupakan bagian penting dalam proses pengembangan aplikasi. Dengan adanya proyek ini, saya dapat memahami hubungan antara teori yang dipelajari dan penerapannya secara langsung dalam pengembangan aplikasi menggunakan Flutter.
# AI Disclosure

Dalam pengerjaan proyek MyPortfolio Mobile, saya menggunakan ChatGPT sebagai alat bantu untuk memahami materi Flutter dan membantu menyelesaikan beberapa bagian kode.

### 1. Penggunaan AI

ChatGPT digunakan untuk membantu:
- Memahami fungsi widget dan struktur kode Flutter.
- Membuat fitur tambah, edit, dan hapus proyek.
- Memahami penggunaan `setState()` dan navigasi antarhalaman.
- Memperbaiki kode yang mengalami error.
- Membantu menyusun dokumentasi proyek.


### 2. Keterbatasan AI dan Perbaikan

Selama menggunakan ChatGPT, saya menemukan bahwa kode yang diberikan terkadang belum sepenuhnya sesuai dengan struktur proyek. Beberapa bagian juga perlu disesuaikan agar dapat berjalan dengan baik.

Karena itu, saya tetap melakukan pemeriksaan secara mandiri dengan cara:
- Menyesuaikan kode dengan file proyek yang sudah ada.
- Memeriksa kembali fungsi dan hubungan antarhalaman.
- Menjalankan `flutter analyze` untuk memeriksa kode.
- Menjalankan aplikasi melalui Chrome untuk mencoba fitur tambah, edit, dan hapus proyek.

### 3. Refleksi

Menurut saya, ChatGPT cukup membantu dalam memahami Flutter, terutama ketika menemukan bagian kode yang belum saya pahami. Namun, jawaban AI tidak selalu bisa langsung digunakan sehingga saya tetap perlu membaca, menyesuaikan, dan mencoba kode tersebut sendiri.

Dari proses ini, saya belajar bahwa AI dapat digunakan sebagai alat bantu belajar, tetapi pemahaman terhadap kode dan hasil akhirnya tetap menjadi tanggung jawab saya.

### 4. Bukti Penggunaan AI
https://chatgpt.com/share/6af5d468-81c0-83ec-87b7-9bebfbfd850a

### Tugas 8

#### Pertanyaan Reflektif

**1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.**

`Navigator.push()` digunakan untuk membuka halaman baru tanpa menghapus halaman sebelumnya dari navigation stack. Dengan demikian, pengguna dapat kembali ke halaman sebelumnya menggunakan tombol kembali bawaan perangkat atau browser.

`Navigator.pushReplacement()` digunakan untuk membuka halaman baru sekaligus menggantikan halaman yang sedang aktif. Artinya, halaman sebelumnya tidak lagi menjadi halaman yang dapat dikembalikan melalui tombol kembali.

Sementara itu, `Navigator.pop()` digunakan untuk menutup halaman atau route yang sedang aktif dan kembali ke halaman sebelumnya.

Pada proyek ini, `Navigator.push()` digunakan untuk membuka halaman formulir Pengalaman melalui kartu aksi di halaman utama. Metode ini dipilih agar pengguna tetap dapat kembali ke halaman utama menggunakan tombol kembali.

Untuk opsi Home pada Drawer, digunakan `Navigator.pushReplacement()` dengan tujuan mengarahkan pengguna ke `MyHomePage` sekaligus menggantikan halaman formulir yang sedang dibuka. Dengan begitu, pengguna dapat kembali ke halaman utama melalui menu Drawer tanpa menumpuk halaman baru di navigation stack.

**2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**

`Scaffold` berfungsi sebagai kerangka utama halaman yang menyediakan struktur dasar seperti AppBar, Drawer, dan body. `AppBar` digunakan untuk menampilkan judul halaman serta memberikan identitas visual yang konsisten. Sementara itu, `Drawer` menyediakan navigasi utama agar pengguna dapat berpindah antarhalaman dengan mudah.

Penggunaan struktur tersebut pada halaman utama, formulir proyek, dan formulir pengalaman membuat tampilan serta navigasi aplikasi terasa konsisten. Drawer yang sama juga digunakan kembali pada halaman formulir sehingga pengguna tidak perlu mempelajari pola navigasi yang berbeda.

Contoh penerapan warna tema portofolio adalah penggunaan warna `Colors.indigo` pada AppBar dan DrawerHeader. Warna tersebut juga digunakan sebagai warna utama melalui `ColorScheme.fromSeed(seedColor: Colors.indigo)` pada konfigurasi tema aplikasi. Hal ini membantu menjaga identitas visual ant halaman.

**3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**

Formulir menggunakan `SingleChildScrollView` agar seluruh kolom input tetap dapat diakses meskipun ukuran layar terbatas atau keyboard sedang terbuka. Tanpa widget penggulir, bagian bawah formulir seperti tombol Simpan berisiko tidak terlihat atau sulit dijangkau.

Widget pengatur jarak seperti `SizedBox` digunakan untuk memberikan jarak antar-elemen, misalnya antara judul, kolom input, dan tombol. Jarak yang konsisten membuat formulir lebih rapi, mudah dibaca, dan tidak terlihat terlalu padat.

Kombinasi kedua widget tersebut dipilih agar formulir tetap nyaman digunakan pada berbagai ukuran layar, baik layar komputer maupun perangkat dengan layar lebih kecil.

**4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**

`GlobalKey<FormState>` digunakan untuk mengidentifikasi dan mengakses status Form dari bagian lain dalam widget, termasuk ketika tombol Simpan ditekan.

`validator` berfungsi untuk memeriksa apakah nilai yang dimasukkan pengguna sudah memenuhi ketentuan. Sementara itu, `validate()` menjalankan seluruh validator pada input yang berada di dalam Form dan mengembalikan nilai `true` apabila seluruh input valid atau `false` apabila terdapat input yang tidak valid.

Pada proyek ini, tombol Simpan memanggil `_formKey.currentState!.validate()`. Jika validasi berhasil, aplikasi menampilkan `AlertDialog` yang berisi ringkasan seluruh isian. Jika tidak, pesan kesalahan ditampilkan pada kolom yang bermasalah.

Contoh nilai yang ditolak adalah deskripsi pengalaman yang hanya berisi spasi atau memiliki panjang kurang dari 10 karakter. Nilai tersebut tidak memenuhi ketentuan validasi meskipun pengguna dapat mengetiknya.

Pemilihan jenis input atau papan ketik saja belum cukup karena keduanya hanya membantu membatasi atau mempermudah proses memasukkan data, bukan menjamin bahwa data tersebut benar. Misalnya, pengguna masih dapat memasukkan URL dengan format yang salah pada kolom teks. Oleh karena itu, validator tetap diperlukan untuk memeriksa isi data sebelum diproses.

#### AI Disclosure

Dalam pengerjaan Tugas 8, saya menggunakan ChatGPT sebagai alat bantu untuk memahami konsep Flutter, menyusun struktur formulir, memperbaiki navigasi, dan mengevaluasi kode.

Bantuan AI digunakan secara spesifik pada:
- Memahami penggunaan `StatefulWidget`, `Form`, `GlobalKey<FormState>`, dan validator.
- Menyusun rancangan halaman formulir Pengalaman dengan tujuh input, yaitu posisi/jabatan, nama organisasi, jenis pengalaman, deskripsi, tanggal mulai, tanggal selesai, dan link bukti pengalaman.
- Membantu memahami penggunaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`.
- Membantu mengidentifikasi kemungkinan kesalahan pada import, navigasi Drawer, dan validasi formulir.


Strategi prompting yang digunakan adalah memberikan instruksi secara bertahap, menyertakan potongan kode atau pesan error, kemudian meminta penjelasan dan solusi untuk bagian yang sedang dikerjakan. Setelah memperoleh saran, saya memeriksa kembali kode dan menyesuaikannya dengan struktur proyek yang sudah ada.

Saya tidak langsung menganggap seluruh hasil AI benar. Saran AI tetap perlu diperiksa karena AI dapat memberikan kode yang belum tentu sesuai dengan struktur proyek, kebutuhan tugas, atau versi Flutter yang digunakan. Oleh karena itu, saya melakukan penyesuaian manual pada import file, callback Drawer, navigasi antarhalaman, dan penerapan validasi agar sesuai dengan kebutuhan aplikasi.

Dengan demikian, ChatGPT digunakan sebagai pendamping belajar dan debugging, sedangkan pemahaman, pemeriksaan, pengujian, dan keputusan akhir terhadap implementasi tetap saya lakukan sendiri.

### 4. Bukti Penggunaan AI
https://chatgpt.com/share/6b039daa-d8fc-83ec-a44d-f71c799db5f5
