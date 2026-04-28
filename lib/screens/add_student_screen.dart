import 'package:flutter/material.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Siswa Baru')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: 'NIS')),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: 'Instansi/Perusahaan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Simpan Data Siswa'),
            ),
          ],
        ),
      ),
    );
  }
}
