// lib/main.dart
// ignore_for_file: use_super_parameters

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logbook/firebase_options.dart';
import 'package:provider/provider.dart';

// Sesuaikan path import dengan struktur folder kamu
import 'core/routes/app_router.dart';
import 'core/theme/app_colors.dart';
import 'providers/auth_provider.dart';
import 'providers/attendance_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const LogbookApp());
}

class LogbookApp extends StatelessWidget {
  const LogbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MultiProvider digunakan agar state (Auth & Attendance)
    // bisa diakses dari seluruh screen di dalam aplikasi.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MaterialApp.router(
        title: 'Logbook PKL',
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
          // Opsional: Gunakan font Google Fonts seperti 'Inter' atau 'Poppins'
          // agar tampilannya lebih Gen-Z / editorial.
          fontFamily: 'Inter',
        ),
        // Menghubungkan aplikasi dengan konfigurasi go_router
        routerConfig: appRouter,
      ),
    );
  }
}
