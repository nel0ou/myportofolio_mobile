import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
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
    ItemHomepage('Pengalaman', Icons.work, Colors.deepPurple),
    ItemHomepage('Logout', Icons.logout, Colors.red),
  ];

  // Membuka form proyek hanya jika pengguna sudah login.
  Future<void> _openProjectForm(BuildContext context) async {
    final authState = context.read<AuthState>();

    if (!authState.isLoggedIn) {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

      if (result != true || !context.mounted) return;
    }

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectFormPage()),
    );
  }

  void _handleMenuTap(BuildContext context, ItemHomepage item) {
    if (item.name == 'Lihat Proyek') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectListScreen()),
      );
    } else if (item.name == 'Tambah Proyek') {
      _openProjectForm(context);
    } else if (item.name == 'Pengalaman') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
      );
    } else if (item.name == 'Logout') {
      _handleLogout(context);
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final authState = context.read<AuthState>();

    if (!authState.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belum ada pengguna yang login.')),
      );
      return;
    }

    try {
      await authState.logout();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logout berhasil.')));
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pop(context);
        },
        onAddProjectTap: () {
          Navigator.pop(context);
          _openProjectForm(context);
        },
        onExperienceTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InfoCard(title: 'NPM', content: npm),
                  ),
                  Expanded(
                    child: InfoCard(title: 'Nama', content: nama),
                  ),
                  Expanded(
                    child: InfoCard(title: 'Kelas', content: kelas),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Selamat datang di MyPortfolio Mobile!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
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

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
