import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  // Callback untuk setiap menu navigasi.
  final VoidCallback onHomeTap;
  final VoidCallback onAddProjectTap;
  final VoidCallback onExperienceTap;

  const LeftDrawer({
    super.key,
    required this.onHomeTap,
    required this.onAddProjectTap,
    required this.onExperienceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header Drawer.
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),

          // Menu Home.
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onHomeTap();
            },
          ),

          // Menu Add Project.
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () {
              Navigator.pop(context);
              onAddProjectTap();
            },
          ),

          // Menu Add Experience.
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: () {
              Navigator.pop(context);
              onExperienceTap();
            },
          ),
        ],
      ),
    );
  }
}
