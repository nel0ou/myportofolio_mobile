
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/services/api_service.dart';
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

  void _handleMenuTap(BuildContext context, ItemHomepage item) {
    if (item.name == 'Lihat Proyek') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectListPage(),
        ),
      );
    } else if (item.name == 'Tambah Proyek') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectFormPage(),
        ),
      );
    } else if (item.name == 'Pengalaman') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ExperienceFormPage(),
        ),
      );
    } else if (item.name == 'Logout') {
      _handleLogout(context);
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    if (ApiService.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belum ada token login.'),
        ),
      );
      return;
    }

    try {
      final response = await ApiService.logout();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.statusCode == 204
                ? 'Logout berhasil.'
                : 'Logout gagal: ${response.statusCode}',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
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
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pop(context);
        },
        onAddProjectTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProjectFormPage(),
            ),
          );
        },
        onExperienceTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExperienceFormPage(),
            ),
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

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  Future<List<dynamic>> _fetchProjects() async {
    final response = await ApiService.getProjects();

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil proyek. HTTP ${response.statusCode}: ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is List) {
      return decoded;
    }

    if (decoded is Map && decoded['results'] is List) {
      return decoded['results'] as List<dynamic>;
    }

    throw Exception('Format data proyek dari server tidak sesuai.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProjectListPage(),
                          ),
                        );
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final projects = snapshot.data ?? [];

          if (projects.isEmpty) {
            return const Center(
              child: Text('Belum ada proyek.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              if (project is! Map) {
                return const SizedBox.shrink();
              }

              final title = project['title'] ??
                  project['name'] ??
                  project['nama'] ??
                  'Proyek ${index + 1}';

              final description = project['description'] ??
                  project['deskripsi'] ??
                  'Tidak ada deskripsi.';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.folder),
                  ),
                  title: Text(
                    title.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(description.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
