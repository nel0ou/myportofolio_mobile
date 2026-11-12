
import 'package:flutter/material.dart';

// ==================================================
// MODEL DATA TOMBOL MENU
// ==================================================

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

// ==================================================
// HALAMAN UTAMA PORTOFOLIO
// ==================================================

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // Data pemilik portofolio
  final String npm = "2506620702";
  final String nama = "Naila Salsabila";
  final String kelas = "Kelas C";

  // Daftar tombol menu beserta ikon dan warnanya
  final List<ItemHomepage> items = [
    const ItemHomepage(
      "Lihat Proyek",
      Icons.folder,
      Colors.blue,
    ),
    const ItemHomepage(
      "Tambah Proyek",
      Icons.add_circle,
      Colors.green,
    ),
    const ItemHomepage(
      "Logout",
      Icons.logout,
      Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // KARTU INFORMASI PEMILIK
              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      title: 'NPM',
                      content: npm,
                    ),
                  ),
                  Expanded(
                    child: InfoCard(
                      title: 'Nama',
                      content: nama,
                    ),
                  ),
                  Expanded(
                    child: InfoCard(
                      title: 'Kelas',
                      content: kelas,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // TULISAN SAMBUTAN
              const Text(
                'Selamat datang di MyPortfolio Mobile!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),

              const SizedBox(height: 24),

              // KARTU TOMBOL AKSI
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((ItemHomepage item) {
                  return ItemCard(item: item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// KOMPONEN KARTU INFORMASI
// ==================================================

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// KOMPONEN KARTU TOMBOL AKSI
// ==================================================

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        // Aksi ketika tombol ditekan
        onTap: () {
          if (item.name == "Lihat Proyek") {
            // Membuka halaman daftar proyek
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectPage(),
              ),
            );
          } else {
            // Menampilkan SnackBar untuk tombol lainnya
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    "Kamu telah menekan tombol ${item.name}!",
                  ),
                ),
              );
          }
        },

        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================================================
// HALAMAN DAFTAR PROYEK
// ==================================================

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  // Data contoh proyek
  final List<String> projects = const [
    "Website Portfolio",
    "Aplikasi Mobile Portfolio",
    "Sistem Informasi Akademik",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Proyek"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(
                Icons.folder,
                color: Colors.indigo,
              ),
              title: Text(projects[index]),
              subtitle: const Text("Proyek Portofolio"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
