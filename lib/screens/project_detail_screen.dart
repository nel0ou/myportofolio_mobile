import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Detail'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.projectImageUrl.isNotEmpty)
              Image.network(
                project.projectImageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Gambar proyek tidak dapat dimuat.');
                },
              ),
            const SizedBox(height: 16),
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(project.description),
            const SizedBox(height: 12),
            const Text(
              'Tech Stack',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(project.techStack),
            const SizedBox(height: 12),
            const Text(
              'Project URL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(project.projectUrl),
          ],
        ),
      ),
    );
  }
}
