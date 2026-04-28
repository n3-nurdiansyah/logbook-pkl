import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // READ: Mengambil daftar semua user yang memiliki role 'student'
  Stream<QuerySnapshot> getStudentsList() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'student')
        .snapshots();
  }

  // UPDATE: Guru melengkapi data PKL siswa
  Future<void> updateStudentPklData(
    String uid,
    String companyName,
    String companyAddress,
    String jobPosition,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'company_name': companyName,
        'company_address': companyAddress,
        'job_position': jobPosition,
      });
    } catch (e) {
      throw Exception('Gagal memperbarui data siswa: $e');
    }
  }
}
