
import 'package:flutter/material.dart';

// ==========================================
// 1. MODEL DATA TOMBOL MENU
// ==========================================

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

// ==========================================
// 2. MODEL DATA PROYEK
// ==========================================

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

// ==========================================
// 3. HALAMAN UTAMA
// ==========================================

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String npm = "2506620702";
  final String nama = "Naila Salsabila";
  final String kelas = "Kelas C";

  // Daftar proyek awal.
  final List<Project> projects = [
    const Project(
      title: "Website Portfolio",
      description:
          "Website portfolio pribadi untuk menampilkan profil, pengalaman, dan proyek yang telah dikerjakan.",
      category: "Web Development",
      icon: Icons.language,
    ),
    const Project(
      title: "Aplikasi Mobile Portfolio",
      description:
          "Aplikasi mobile berbasis Flutter untuk menampilkan informasi pemilik portfolio dan daftar proyek.",
      category: "Mobile Development",
      icon: Icons.phone_android,
    ),
    const Project(
      title: "Sistem Informasi Akademik",
      description:
          "Sistem informasi untuk membantu pengelolaan data dan informasi akademik.",
      category: "Information System",
      icon: Icons.school,
    ),
  ];

  final List<ItemHomepage> items = [
    const ItemHomepage("Lihat Proyek", Icons.folder, Colors.blue),
    const ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green),
    const ItemHomepage("Logout", Icons.logout, Colors.red),
  ];

  // Membuka halaman tambah proyek dari halaman utama.
  Future<void> _openAddProject() async {
    final newProject = await Navigator.push<Project>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProjectPage(),
      ),
    );

    // Memastikan halaman masih aktif setelah await.
    if (!mounted) return;

    if (newProject != null) {
      setState(() {
        projects.add(newProject);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Proyek berhasil ditambahkan!"),
        ),
      );
    }
  }

  // Membuka halaman daftar proyek.
  void _openProjectList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectListPage(
          projects: projects,
          onAddProject: (project) {
            setState(() {
              projects.add(project);
            });
          },
        ),
      ),
    );
  }

  // Mengatur aksi tombol menu.
  void _handleMenuTap(ItemHomepage item) {
    if (item.name == "Lihat Proyek") {
      _openProjectList();
    } else if (item.name == "Tambah Proyek") {
      _openAddProject();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Fitur Logout belum dihubungkan ke autentikasi.",
          ),
        ),
      );
    }
  }

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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: "NPM",
                    content: npm,
                  ),
                ),
                Expanded(
                  child: InfoCard(
                    title: "Nama",
                    content: nama,
                  ),
                ),
                Expanded(
                  child: InfoCard(
                    title: "Kelas",
                    content: kelas,
                  ),
                ),
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
              childAspectRatio: 0.85,
              children: items.map((item) {
                return ItemCard(
                  item: item,
                  onTap: () => _handleMenuTap(item),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. KOMPONEN KARTU INFORMASI
// ==========================================

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

// ==========================================
// 5. KOMPONEN KARTU TOMBOL AKSI
// ==========================================

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
          child: Padding(
            padding: const EdgeInsets.all(8),
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

// ==========================================
// 6. HALAMAN DAFTAR PROYEK
// ==========================================

class ProjectListPage extends StatefulWidget {
  final List<Project> projects;
  final ValueChanged<Project> onAddProject;

  const ProjectListPage({
    super.key,
    required this.projects,
    required this.onAddProject,
  });

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  // Membuka formulir tambah proyek dari daftar proyek.
  Future<void> _addProject() async {
    final newProject = await Navigator.push<Project>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProjectPage(),
      ),
    );

    if (!mounted) return;

    if (newProject != null) {
      widget.onAddProject(newProject);

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Proyek berhasil ditambahkan!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Proyek"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: "Tambah Proyek",
            icon: const Icon(Icons.add),
            onPressed: _addProject,
          ),
        ],
      ),
      body: widget.projects.isEmpty
          ? const Center(
              child: Text("Belum ada proyek."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.projects.length,
              itemBuilder: (context, index) {
                final project = widget.projects[index];

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
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
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

// ==========================================
// 7. HALAMAN TAMBAH PROYEK
// ==========================================

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController =
      TextEditingController();

  final TextEditingController _descriptionController =
      TextEditingController();

  String _selectedCategory = "Web Development";

  final List<String> categories = [
    "Web Development",
    "Mobile Development",
    "Information System",
    "UI/UX Design",
    "Other",
  ];

  // Menentukan ikon berdasarkan kategori.
  IconData _getProjectIcon(String category) {
    switch (category) {
      case "Web Development":
        return Icons.language;
      case "Mobile Development":
        return Icons.phone_android;
      case "Information System":
        return Icons.school;
      case "UI/UX Design":
        return Icons.design_services;
      default:
        return Icons.work;
    }
  }

  // Menyimpan data proyek.
  void _saveProject() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newProject = Project(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      icon: _getProjectIcon(_selectedCategory),
    );

    // Mengembalikan proyek ke halaman sebelumnya.
    Navigator.pop(context, newProject);
  }

  @override
  void dispose() {
    // Membersihkan controller setelah halaman ditutup.
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Proyek"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Informasi Proyek",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Input nama proyek.
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Nama Proyek",
                  hintText: "Contoh: Website Portfolio",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nama proyek tidak boleh kosong.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Pilihan kategori proyek.
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Kategori Proyek",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              // Input deskripsi proyek.
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Deskripsi Proyek",
                  hintText: "Jelaskan tentang proyek yang dibuat...",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Deskripsi proyek tidak boleh kosong.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 28),

              // Tombol simpan.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveProject,
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan Proyek"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 8. HALAMAN DETAIL PROYEK
// ==========================================

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
        child: SingleChildScrollView(
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
