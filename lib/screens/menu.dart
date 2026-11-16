
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506620702';
  final String nama = 'Naila Salsabila';
  final String kelas = 'Kelas C';

  final List<ItemHomepage> items = const [
    ItemHomepage('Lihat Proyek', Icons.folder, Colors.blue),
    ItemHomepage('Tambah Proyek', Icons.add_circle, Colors.green),
    ItemHomepage('Logout', Icons.logout, Colors.red),
  ];

  void _handleMenuTap(BuildContext context, ItemHomepage item) {
    // Menampilkan SnackBar ketika tombol ditekan.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Kamu telah menekan tombol ${item.name}!',
          ),
        ),
      );

    // Navigasi ke halaman form ketika Tambah Proyek ditekan.
    if (item.name == 'Tambah Proyek') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectFormPage(),
        ),
      );
    }
  }

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
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Drawer untuk navigasi halaman.
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        },
        onAddProjectTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProjectFormPage(),
            ),
          );
        },
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Informasi pemilik portfolio.
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

              const Text(
                'Selamat datang di MyPortfolio Mobile!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 24),

              // Menampilkan tiga tombol menu.
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
                children: items.map((item) {
                  return ItemCard(
                    item: item,
                    onTap: () => _handleMenuTap(context, item),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Kartu informasi pemilik portfolio.
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
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
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
