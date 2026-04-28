import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monitoring Siswa PKL')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Contoh data
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text('Siswa Ke-${index + 1}'),
              subtitle: const Text('Aktivitas: Coding Flutter - Hadir'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigasi ke detail jika diperlukan
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/teacher/add-student'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton.icon(
          onPressed: () => context.push('/teacher/reports'),
          icon: const Icon(Icons.print),
          label: const Text('Menu Laporan'),
        ),
      ),
    );
  }
}
