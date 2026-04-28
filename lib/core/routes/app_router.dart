import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../screens/login_screen.dart';
import '../../screens/dashboard_screen.dart';
import '../../screens/attendance_form_screen.dart';
import '../../screens/history_screen.dart';
import '../../screens/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final String? role = authProvider.userRole;
    final bool isGoingToLogin = state.uri.toString() == '/login';
    if (!isLoggedIn && !isGoingToLogin) {
      return '/login';
    }
    if (isLoggedIn && isGoingToLogin) {
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
  ],
);
