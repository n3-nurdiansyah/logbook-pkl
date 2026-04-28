// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// ─── Color Palette ──────────────────────────────────────────────────────────
class AppColors {
  static const Color primary = Color(0xFF16A34A); // Green-600
  static const Color primaryLight = Color(0xFF22C55E); // Green-500
  static const Color primaryDark = Color(0xFF15803D); // Green-700
  static const Color primarySoft = Color(0xFFDCFCE7); // Green-100
  static const Color accent = Color(0xFF4ADE80); // Green-400
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8FFF9);
  static const Color cardBorder = Color(0xFFE2F5E9);
  static const Color textPrimary = Color(0xFF14532D); // Green-900
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}

// ─── Teacher Dashboard Screen ────────────────────────────────────────────────
class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..forward();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Animation<double> _anim(double begin, double end) =>
      Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: _mainController, curve: Curves.easeOutCubic),
      );

  Animation<Offset> _slide(
    double fromX,
    double fromY,
    double start,
    double finish,
  ) => Tween<Offset>(begin: Offset(fromX, fromY), end: Offset.zero).animate(
    CurvedAnimation(
      parent: _mainController,
      curve: Interval(start, finish, curve: Curves.easeOutCubic),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildHeroStats(),
                    const SizedBox(height: 24),
                    _buildLiveAttendanceBanner(),
                    const SizedBox(height: 24),
                    _buildMenuGrid(),
                    const SizedBox(height: 24),
                    _buildRecentSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Top Bar ──────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return FadeTransition(
      opacity: _anim(0, 1),
      child: SlideTransition(
        position: _slide(0, -0.5, 0, 0.5),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar + Greeting
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryLight, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'BU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Bu Sari Dewi',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              // Notification Bell
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        LucideIcons.bell,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Logout
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(
                      LucideIcons.logOut,
                      color: AppColors.danger,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Hero Stats Row ────────────────────────────────────────────────────────
  Widget _buildHeroStats() {
    return SlideTransition(
      position: _slide(0, 0.4, 0.1, 0.7),
      child: FadeTransition(
        opacity: _anim(0, 1),
        child: Row(
          children: [
            _heroStat(
              '32',
              'Total Siswa',
              LucideIcons.users,
              AppColors.primary,
              0.1,
            ),
            const SizedBox(width: 12),
            _heroStat(
              '28',
              'Hadir Hari Ini',
              LucideIcons.checkCircle2,
              AppColors.success,
              0.2,
            ),
            const SizedBox(width: 12),
            _heroStat(
              '4',
              'Tidak Hadir',
              LucideIcons.xCircle,
              AppColors.danger,
              0.3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroStat(
    String val,
    String label,
    IconData icon,
    Color color,
    double delay,
  ) {
    return Expanded(
      child: AnimatedBuilder(
        animation: _mainController,
        builder: (context, child) {
          final anim = CurvedAnimation(
            parent: _mainController,
            curve: Interval(delay, delay + 0.5, curve: Curves.easeOutBack),
          );
          return Transform.scale(
            scale: Tween<double>(begin: 0.7, end: 1.0).evaluate(anim),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.15), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                val,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Live Attendance Banner ────────────────────────────────────────────────
  Widget _buildLiveAttendanceBanner() {
    return SlideTransition(
      position: _slide(-0.3, 0, 0.2, 0.75),
      child: FadeTransition(
        opacity: _anim(0, 1),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RealtimeAbsensiScreen()),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF16A34A), Color(0xFF15803D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  bottom: -40,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) => Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(
                                      0.6 + 0.4 * _pulseController.value,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(
                                          0.5 * _pulseController.value,
                                        ),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'LIVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Monitor Absensi\nRealtime PKL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Lihat Sekarang',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  LucideIcons.arrowRight,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.scanLine,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Menu Grid ─────────────────────────────────────────────────────────────
  Widget _buildMenuGrid() {
    final menus = [
      _MenuData(
        'Data Siswa',
        LucideIcons.users,
        AppColors.info,
        const StudentListScreen(),
      ),
      _MenuData(
        'Absensi\nRealtime',
        LucideIcons.activitySquare,
        AppColors.success,
        const RealtimeAbsensiScreen(),
      ),
      _MenuData(
        'Riwayat\nAbsensi',
        LucideIcons.calendarCheck2,
        AppColors.warning,
        const HistoryAbsensiScreen(),
      ),
      _MenuData(
        'Buat\nLaporan',
        LucideIcons.fileSpreadsheet,
        AppColors.danger,
        const LaporanScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menu Utama',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.35,
          ),
          itemCount: menus.length,
          itemBuilder: (context, i) {
            return AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                final anim = CurvedAnimation(
                  parent: _mainController,
                  curve: Interval(
                    0.3 + i * 0.08,
                    1.0,
                    curve: Curves.easeOutBack,
                  ),
                );
                return Transform.scale(
                  scale: Tween<double>(begin: 0.6, end: 1.0).evaluate(anim),
                  child: Opacity(
                    opacity: Tween<double>(begin: 0, end: 1).evaluate(anim),
                    child: child,
                  ),
                );
              },
              child: _buildMenuCard(menus[i]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuCard(_MenuData menu) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => menu.screen),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: menu.color.withOpacity(0.15), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: menu.color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: menu.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(menu.icon, color: menu.color, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menu.title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Buka',
                      style: TextStyle(
                        fontSize: 11,
                        color: menu.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(LucideIcons.arrowRight, color: menu.color, size: 12),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Recent Activity ───────────────────────────────────────────────────────
  Widget _buildRecentSection() {
    final items = [
      _ActivityData(
        'Budi Santoso',
        'Masuk • 07:52',
        '2 mnt lalu',
        Colors.green,
      ),
      _ActivityData('Rina Putri', 'Masuk • 08:05', '15 mnt lalu', Colors.green),
      _ActivityData(
        'Doni Rahmat',
        'Terlambat • 09:10',
        '1 jam lalu',
        Colors.orange,
      ),
      _ActivityData('Siti Aisyah', 'Izin hari ini', 'Hari ini', Colors.red),
    ];

    return SlideTransition(
      position: _slide(0, 0.3, 0.5, 1.0),
      child: FadeTransition(
        opacity: _anim(0, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Aktivitas Terkini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HistoryAbsensiScreen(),
                    ),
                  ),
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...items.asMap().entries.map(
              (e) => _buildActivityTile(e.value, e.key),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityTile(_ActivityData data, int index) {
    final initials = data.name.split(' ').map((w) => w[0]).take(2).join();
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        final anim = CurvedAnimation(
          parent: _mainController,
          curve: Interval(0.55 + index * 0.06, 1.0, curve: Curves.easeOutCubic),
        );
        return Transform.translate(
          offset: Offset(60 * (1 - anim.value), 0),
          child: Opacity(opacity: anim.value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.cardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: data.color,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    data.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: data.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              data.time,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textHint,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bottom Nav ────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      (LucideIcons.layoutDashboard, 'Beranda'),
      (LucideIcons.users, 'Siswa'),
      (LucideIcons.clipboardList, 'Absensi'),
      (LucideIcons.fileText, 'Laporan'),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((e) {
          final selected = _selectedIndex == e.key;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = e.key);
              if (e.key == 1)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudentListScreen()),
                );
              if (e.key == 2)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RealtimeAbsensiScreen(),
                  ),
                );
              if (e.key == 3)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LaporanScreen()),
                );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(
                horizontal: selected ? 18 : 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: selected ? AppColors.primarySoft : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    e.value.$1,
                    size: 22,
                    color: selected ? AppColors.primary : AppColors.textHint,
                  ),
                  if (selected) ...[
                    const SizedBox(width: 8),
                    Text(
                      e.value.$2,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getGreeting() {
    final h = DateTime.now().hour;
    if (h < 11) return 'Selamat Pagi 🌤️';
    if (h < 15) return 'Selamat Siang ☀️';
    if (h < 18) return 'Selamat Sore 🌇';
    return 'Selamat Malam 🌙';
  }
}

// ─── Data Models (UI only) ────────────────────────────────────────────────────
class _MenuData {
  final String title;
  final IconData icon;
  final Color color;
  final Widget screen;
  const _MenuData(this.title, this.icon, this.color, this.screen);
}

class _ActivityData {
  final String name, status, time;
  final Color color;
  const _ActivityData(this.name, this.status, this.time, this.color);
}

// ─── Placeholder exports (screens below) ─────────────────────────────────────
// These are just stubs here — actual implementations are in separate files.
class RealtimeAbsensiScreen extends StatelessWidget {
  const RealtimeAbsensiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Realtime Absensi')));
}

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Student List')));
}

class HistoryAbsensiScreen extends StatelessWidget {
  const HistoryAbsensiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('History Absensi')));
}

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Laporan')));
}
