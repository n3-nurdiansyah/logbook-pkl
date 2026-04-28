import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;
  String? _userRole;
  String? get userRole => _userRole;

  AuthProvider() {
    _auth.authStateChanges().listen((User? currentUser) {
      _user = currentUser;
      if (currentUser != null) {
        _syncUserToFirestore(currentUser);
      }
      notifyListeners();
    });
  }

  Future<void> _syncUserToFirestore(User currentUser) async {
    final docRef = _firestore.collection('users').doc(currentUser.uid);
    final docSnap = await docRef.get();

    // Jika dokumen sudah ada, cukup ambil role-nya
    if (docSnap.exists) {
      _userRole = docSnap.data()?['role'] ?? 'student';
      notifyListeners();
      print('User sudah ada di Firestore dengan role: $_userRole');
      return;
    }

    // Jika belum ada (baru pertama kali register/Google Sign-In), buat dokumen baru
    await docRef.set({
      'email': currentUser.email,
      'name': currentUser.displayName ?? 'Siswa Tanpa Nama',
      'role': 'student', // Default otomatis jadi siswa
      'company_name': '', // Tempat PKL (Nanti diisi oleh Guru)
      'company_address': '',
      'job_position': '',
      'created_at': Timestamp.now(),
    });

    _userRole = 'student';
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoggedIn ? notifyListeners() : null;
      if (credential.user == null) return;
      await _syncUserToFirestore(credential.user!);
    } catch (e) {
      throw Exception('Gagal Login ${e.toString()}');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider.addScope(
        'https://www.googleapis.com/auth/contacts.readonly',
      );
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      final credential = await _auth.signInWithPopup(googleProvider);
      if (credential.user != null) {
        await _syncUserToFirestore(credential.user!);
      }
    } catch (e) {
      throw Exception('Gagal Login ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _userRole = null;
    notifyListeners();
  }
}
