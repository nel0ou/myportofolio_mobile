
import 'package:flutter/material.dart';

// MODEL DATA TOMBOL MENU
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

// MODEL DATA PROYEK
class Project {
  final String title;
  final String description;
  final String category;
  final IconData icon;

  const Project({
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
  });
}

// HALAMAN UTAMA
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506620702";
  final String nama = "Naila Salsabila";
  final String kelas = "Kelas C";

  final List<ItemHomepage> items = [
    const ItemHomepage("Lihat Proyek", Icons.folder, Colors.blue),
    const ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green),
    const ItemHomepage("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyPortfolio",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: InfoCard(title: "NPM", content: npm)),
                  Expanded(child: InfoCard(title: "Nama", content: nama)),
                  Expanded(child: InfoCard(title: "Kelas", content: kelas)),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                "Selamat datang di MyPortfolio Mobile!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: items.map((item) {
                  return ItemCard(
                    item: item,
                    onTap: () {
                      if (item.name == "Lihat Proyek") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProjectListPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Kamu menekan tombol ${item.name}!",
                            ),
                          ),
                        );
                      }
                    },
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

// KOMPONEN KARTU INFORMASI
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// KOMPONEN KARTU TOMBOL AKSI
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HALAMAN DAFTAR PROYEK
class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  final List<Project> projects = const [
    Project(
      title: "Website Portfolio",
      description:
          "Website portfolio pribadi untuk menampilkan profil, pengalaman, dan proyek yang telah dikerjakan.",
      category: "Web Development",
      icon: Icons.language,
    ),
    Project(
      title: "Aplikasi Mobile Portfolio",
      description:
          "Aplikasi mobile berbasis Flutter untuk menampilkan informasi pemilik portfolio dan daftar proyek.",
      category: "Mobile Development",
      icon: Icons.phone_android,
    ),
    Project(
      title: "Sistem Informasi Akademik",
      description:
          "Sistem informasi untuk membantu pengelolaan data dan informasi akademik.",
      category: "Information System",
      icon: Icons.school,
    ),
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
          final project = projects[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                project.icon,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              title: Text(project.title),
              subtitle: Text("Proyek ${project.category}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailPage(
                      project: project,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// HALAMAN DETAIL PROYEK
class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Proyek"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    project.icon,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    project.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.category,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    project.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
