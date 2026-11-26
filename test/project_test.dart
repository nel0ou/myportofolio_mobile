import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/project.dart';

void main() {
  group('Project model', () {
    test('converts JSON into Project correctly', () {
      final json = {
        'id': '123',
        'title': 'Tes Project',
        'description': 'Deskripsi project',
        'tech_stack': 'Flutter, Django',
        'link_url': 'https://example.com',
        'star_count': 0,
      };

      final project = Project.fromJson(json);

      expect(project.title, 'Tes Project');
      expect(project.description, 'Deskripsi project');
      expect(project.techStack, 'Flutter, Django');
      expect(project.projectUrl, 'https://example.com');
    });
  });
}
