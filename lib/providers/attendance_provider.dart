import 'package:flutter/material.dart';

class AttendanceProvider extends ChangeNotifier {
  // Mock data riwayat PKL
  final List<Map<String, dynamic>> _history = [
    {
      'date': '16 Apr 2026',
      'activity': 'Setup Golang & Supabase',
      'status': 'Verified',
    },
    {
      'date': '15 Apr 2026',
      'activity': 'Slicing UI Dashboard',
      'status': 'Verified',
    },
    {
      'date': '14 Apr 2026',
      'activity': 'Meeting Sprint 1',
      'status': 'Pending',
    },
  ];

  List<Map<String, dynamic>> get history => _history;

  Future<void> submitAttendance(String description) async {

    _history.insert(0, {
      'date': 'Hari ini',
      'activity': description,
      'status': 'Pending',
    });
    notifyListeners();
  }
}
