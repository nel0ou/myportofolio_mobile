
import 'package:flutter/material.dart';

// ==========================================
// 1. MODEL DATA MENU
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506620702";
  final String nama = "Naila Salsabila";
  final String kelas = "Kelas C";

  // Data proyek awal.
  static final List<Project> projects = [
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

  final List<ItemHomepage> items = const [
    ItemHomepage("Lihat Proyek", Icons.folder, Colors.blue),
    ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green),
    ItemHomepage("Logout", Icons.logout, Colors.red),
  ];

  // Membuka halaman tambah proyek.
  Future<void> _openAddProject(BuildContext context) async {
    final newProject = await Navigator.push<Project>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProjectPage(),
      ),
    );

    if (!context.mounted) return;

    if (newProject != null) {
      projects.add(newProject);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Proyek berhasil ditambahkan!"),
        ),
      );
    }
  }

  // Membuka halaman daftar proyek.
  void _openProjectList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectListPage(
          projects: projects,
          onAddProject: (project) {
            projects.add(project);
          },
        ),
      ),
    );
  }

  // Mengatur aksi tombol menu dan SnackBar.
  void _handleMenuTap(BuildContext context, ItemHomepage item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Kamu telah menekan tombol ${item.name}!",
        ),
      ),
    );

    if (item.name == "Lihat Proyek") {
      _openProjectList(context);
    } else if (item.name == "Tambah Proyek") {
      _openAddProject(context);
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
                  onTap: () => _handleMenuTap(context, item),
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
// 5. KOMPONEN KARTU MENU
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
  // Membuka formulir tambah proyek.
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

  // Membuka halaman detail proyek.
  void _openProjectDetail(Project project) {
    final projectIndex = widget.projects.indexOf(project);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailPage(
          project: project,

          // Callback untuk menghapus proyek.
          onDelete: () {
            if (projectIndex >= 0 &&
                projectIndex < widget.projects.length) {
              setState(() {
                widget.projects.removeAt(projectIndex);
              });
            }
          },

          // Callback untuk memperbarui proyek.
          onUpdate: (updatedProject) {
            if (projectIndex >= 0 &&
                projectIndex < widget.projects.length) {
              setState(() {
                widget.projects[projectIndex] = updatedProject;
              });
            }
          },
        ),
      ),
    );
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
                      _openProjectDetail(project);
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

  // Menyimpan proyek baru.
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

    Navigator.pop(context, newProject);
  }

  @override
  void dispose() {
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

              // Pilihan kategori.
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
// 8. HALAMAN EDIT PROYEK
// ==========================================

class EditProjectPage extends StatefulWidget {
  final Project project;

  const EditProjectPage({
    super.key,
    required this.project,
  });

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late String _selectedCategory;

  final List<String> categories = [
    "Web Development",
    "Mobile Development",
    "Information System",
    "UI/UX Design",
    "Other",
  ];

  @override
  void initState() {
    super.initState();

    // Mengisi form dengan data proyek sebelumnya.
    _titleController = TextEditingController(
      text: widget.project.title,
    );

    _descriptionController = TextEditingController(
      text: widget.project.description,
    );

    _selectedCategory = widget.project.category;
  }

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

  // Menyimpan perubahan proyek.
  void _updateProject() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedProject = Project(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      icon: _getProjectIcon(_selectedCategory),
    );

    Navigator.pop(context, updatedProject);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Proyek"),
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
                "Ubah Informasi Proyek",
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

              // Pilihan kategori.
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

              // Tombol simpan perubahan.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _updateProject,
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan Perubahan"),
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
// 9. HALAMAN DETAIL PROYEK
// ==========================================

class ProjectDetailPage extends StatefulWidget {
  final Project project;
  final VoidCallback onDelete;
  final ValueChanged<Project> onUpdate;

  const ProjectDetailPage({
    super.key,
    required this.project,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<ProjectDetailPage> createState() =>
      _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  // Membuka halaman edit proyek.
  Future<void> _editProject() async {
    final updatedProject = await Navigator.push<Project>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProjectPage(
          project: _project,
        ),
      ),
    );

    if (!mounted) return;

    if (updatedProject != null) {
      setState(() {
        _project = updatedProject;
      });

      widget.onUpdate(updatedProject);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Proyek berhasil diperbarui!"),
        ),
      );
    }
  }

  // Dialog konfirmasi sebelum menghapus proyek.
  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Hapus Proyek?"),
          content: Text(
            'Apakah kamu yakin ingin menghapus "${_project.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) return;

    // Menyimpan messenger sebelum halaman ditutup.
    final messenger = ScaffoldMessenger.of(context);

    // Memanggil fungsi hapus di halaman daftar.
    widget.onDelete();

    Navigator.pop(context);

    messenger.showSnackBar(
      const SnackBar(
        content: Text("Proyek berhasil dihapus!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Proyek"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Tombol edit.
          IconButton(
            tooltip: "Edit Proyek",
            icon: const Icon(Icons.edit),
            onPressed: _editProject,
          ),

          // Tombol hapus.
          IconButton(
            tooltip: "Hapus Proyek",
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete,
          ),
        ],
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
                    _project.icon,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _project.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _project.category,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    _project.description,
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
