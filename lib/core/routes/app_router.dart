import 'package:go_router/go_router.dart';
import 'package:logbook/screens/add_student_screen.dart';
import 'package:logbook/screens/report_screen.dart';
import 'package:logbook/screens/teacher_dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../screens/login_screen.dart';
import '../../screens/dashboard_screen.dart';
import '../../screens/attendance_form_screen.dart';
import '../../screens/history_screen.dart';
import '../../screens/splash_screen.dart';
import '../../providers/auth_provider.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final bool isLoggedIn = authProvider.isLoggedIn;
    final String? role = authProvider.userRole;
    final String location = state.uri.toString();
    final bool isGoingToLogin = location == '/login';
    final bool isGoingToSplash = location == '/';

    // 1. Jika belum login, paksa ke halaman login kecuali sedang di splash
    if (!isLoggedIn) {
      return (isGoingToLogin || isGoingToSplash) ? null : '/login';
    }

    // 2. Jika sudah login dan mencoba akses Login/Splash atau Dashboard Siswa padahal dia Guru
    // Ini memastikan user selalu mendarat di dashboard yang benar
    if (isGoingToLogin ||
        isGoingToSplash ||
        (role == 'teacher' && location == '/dashboard')) {
      return (role == 'teacher') ? '/teacher' : '/dashboard';
    }

    // 3. Proteksi tambahan: Siswa tidak boleh akses path yang dimulai dengan /teacher
    if (role == 'student' && location.startsWith('/teacher')) {
      return '/dashboard';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/absen-form',
      builder: (context, state) => const AttendanceFormScreen(),
    ),
    GoRoute(
      path: '/riwayat',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: '/teacher',
      builder: (context, state) => const TeacherDashboardScreen(),
      routes: [
        GoRoute(
          path: 'add-student',
          builder: (context, state) => const AddStudentScreen(),
        ),
        GoRoute(
          path: 'reports',
          builder: (context, state) => const ReportScreen(),
        ),
      ],
    ),
  ],
);
