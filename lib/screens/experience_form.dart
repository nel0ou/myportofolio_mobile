import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  // Key untuk mengakses dan memvalidasi seluruh form.
  final _formKey = GlobalKey<FormState>();

  // Controller untuk menampilkan tanggal yang dipilih.
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String _position = '';
  String _organization = '';
  String? _experienceType;
  String _description = '';
  String _evidenceLink = '';

  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _experienceTypes = [
    'Internship',
    'Organisasi',
    'Volunteer',
    'Part-time',
    'Full-time',
    'Kepanitiaan',
    'Other',
  ];

  // Memilih tanggal mulai.
  Future<void> _selectStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
        _startDateController.text =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';

        // Tanggal selesai harus setelah atau sama dengan tanggal mulai.
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
          _endDateController.clear();
        }
      });
    }
  }

  // Memilih tanggal selesai.
  Future<void> _selectEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
        _endDateController.text =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  // Menampilkan dialog ringkasan pengalaman.
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Pengalaman berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Posisi: $_position'),
                const SizedBox(height: 8),
                Text('Nama Organisasi: $_organization'),
                const SizedBox(height: 8),
                Text('Jenis Pengalaman: $_experienceType'),
                const SizedBox(height: 8),
                Text('Deskripsi: $_description'),
                const SizedBox(height: 8),
                Text('Tanggal Mulai: ${_startDateController.text}'),
                const SizedBox(height: 8),
                Text('Tanggal Selesai: ${_endDateController.text}'),
                const SizedBox(height: 8),
                Text(
                  'Link Bukti: ${_evidenceLink.isEmpty ? '-' : _evidenceLink}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(dialogContext);

                _formKey.currentState!.reset();

                setState(() {
                  _position = '';
                  _organization = '';
                  _experienceType = null;
                  _description = '';
                  _evidenceLink = '';
                  _startDate = null;
                  _endDate = null;
                  _startDateController.clear();
                  _endDateController.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengalaman'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
        onAddProjectTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProjectFormPage()),
          );
        },
        onExperienceTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
          );
        },
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Posisi/Jabatan
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Posisi/Jabatan',
                    hintText: 'Contoh: Ketua Divisi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _position = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Posisi/Jabatan wajib diisi!';
                    }
                    return null;
                  },
                ),
              ),

              // 2. Nama Organisasi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Organisasi',
                    hintText: 'Masukkan nama organisasi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _organization = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama organisasi wajib diisi!';
                    }
                    return null;
                  },
                ),
              ),

              // 3. Jenis Pengalaman
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Jenis Pengalaman',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _experienceType,
                  items: _experienceTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _experienceType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih jenis pengalaman!';
                    }
                    return null;
                  },
                ),
              ),

              // 4. Deskripsi Pengalaman
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Pengalaman',
                    hintText: 'Jelaskan pengalaman dan tanggung jawabmu',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _description = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi pengalaman wajib diisi!';
                    }
                    if (value.trim().length < 10) {
                      return 'Deskripsi minimal 10 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // 5. Tanggal Mulai
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  onTap: _selectStartDate,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Mulai',
                    hintText: 'Pilih tanggal mulai',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (_startDate == null) {
                      return 'Tanggal mulai wajib dipilih!';
                    }
                    return null;
                  },
                ),
              ),

              // 6. Tanggal Selesai
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  onTap: _selectEndDate,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Selesai',
                    hintText: 'Pilih tanggal selesai',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (_endDate == null) {
                      return 'Tanggal selesai wajib dipilih!';
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
                    }
                    return null;
                  },
                ),
              ),

              // 7. Link Bukti Pengalaman
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: 'Link Bukti Pengalaman (Opsional)',
                    hintText: 'https://contoh.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _evidenceLink = value.trim();
                  },
                  validator: (value) {
                    final link = value?.trim() ?? '';

                    if (link.isEmpty) {
                      return null;
                    }

                    final uri = Uri.tryParse(link);
                    if (uri == null ||
                        !uri.hasScheme ||
                        (uri.scheme != 'http' && uri.scheme != 'https') ||
                        uri.host.isEmpty) {
                      return 'Masukkan URL yang valid (http/https)!';
                    }

                    return null;
                  },
                ),
              ),

              // Tombol Simpan
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSuccessDialog();
                      }
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
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
