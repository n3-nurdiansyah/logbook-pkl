// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// ─── Color Palette (reuse from app_colors.dart in real project) ───────────────
class _C {
  static const primary = Color(0xFF16A34A);
  static const primaryLight = Color(0xFF22C55E);
  static const primarySoft = Color(0xFFDCFCE7);
  static const textPrimary = Color(0xFF14532D);
  static const textSecondary = Color(0xFF6B7280);
  static const textHint = Color(0xFF9CA3AF);
  static const cardBorder = Color(0xFFE2F5E9);
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
  static const bg = Color(0xFFF8FFF9);
}

class RealtimeAbsensiScreen extends StatefulWidget {
  const RealtimeAbsensiScreen({Key? key}) : super(key: key);

  @override
  State<RealtimeAbsensiScreen> createState() => _RealtimeAbsensiScreenState();
}

class _RealtimeAbsensiScreenState extends State<RealtimeAbsensiScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _entryCtrl;
  String _filterStatus = 'Semua';

  final _students = [
    _StudentAttendance(
      'Budi Santoso',
      'PT. Maju Bersama',
      'Backend Dev',
      '07:52',
      _Status.hadir,
    ),
    _StudentAttendance(
      'Rina Putri',
      'CV. Digital Nusa',
      'UI Designer',
      '08:05',
      _Status.hadir,
    ),
    _StudentAttendance(
      'Doni Rahmat',
      'PT. Solusi IT',
      'Frontend Dev',
      '09:10',
      _Status.terlambat,
    ),
    _StudentAttendance(
      'Siti Aisyah',
      'PT. TechnoInd',
      'Data Analyst',
      '-',
      _Status.izin,
    ),
    _StudentAttendance(
      'Fajar Kurnia',
      'CV. Kreasi Digital',
      'Mobile Dev',
      '07:45',
      _Status.hadir,
    ),
    _StudentAttendance(
      'Dewi Lestari',
      'PT. Maju Bersama',
      'QA Tester',
      '08:30',
      _Status.hadir,
    ),
    _StudentAttendance(
      'Rizky Andika',
      'PT. Solusi IT',
      'Backend Dev',
      '-',
      _Status.alpha,
    ),
    _StudentAttendance(
      'Nadia Sari',
      'CV. Digital Nusa',
      'UI Designer',
      '08:12',
      _Status.hadir,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  List<_StudentAttendance> get _filtered {
    if (_filterStatus == 'Semua') return _students;
    return _students.where((s) => s.status.label == _filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSummaryRow(),
            _buildFilterChips(),
            Expanded(child: _buildStudentList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: _C.primary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _C.primarySoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    LucideIcons.arrowLeft,
                    color: _C.primary,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monitor Absensi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _C.textPrimary,
                      ),
                    ),
                    Text(
                      _formatDate(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: _C.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Live indicator
              AnimatedBuilder(
                animation: _pulseCtrl,
                builder: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _C.success.withOpacity(
                      0.1 + 0.05 * _pulseCtrl.value,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _C.success.withOpacity(
                        0.3 + 0.2 * _pulseCtrl.value,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _C.success,
                          boxShadow: [
                            BoxShadow(
                              color: _C.success.withOpacity(
                                0.6 * _pulseCtrl.value,
                              ),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: _C.success,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow() {
    final hadir = _students.where((s) => s.status == _Status.hadir).length;
    final terlambat = _students
        .where((s) => s.status == _Status.terlambat)
        .length;
    final izin = _students.where((s) => s.status == _Status.izin).length;
    final alpha = _students.where((s) => s.status == _Status.alpha).length;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF16A34A), Color(0xFF15803D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _C.primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem('$hadir', 'Hadir', LucideIcons.checkCircle2),
          _divider(),
          _summaryItem('$terlambat', 'Terlambat', LucideIcons.clock),
          _divider(),
          _summaryItem('$izin', 'Izin', LucideIcons.fileCheck),
          _divider(),
          _summaryItem('$alpha', 'Alpha', LucideIcons.xCircle),
        ],
      ),
    );
  }

  Widget _summaryItem(String val, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 18),
        const SizedBox(height: 6),
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _divider() =>
      Container(height: 40, width: 1, color: Colors.white.withOpacity(0.2));

  Widget _buildFilterChips() {
    final filters = ['Semua', 'Hadir', 'Terlambat', 'Izin', 'Alpha'];
    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final sel = _filterStatus == filters[i];
          return GestureDetector(
            onTap: () => setState(() => _filterStatus = filters[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: sel ? _C.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: sel ? _C.primary : _C.cardBorder,
                  width: 1.5,
                ),
                boxShadow: sel
                    ? [
                        BoxShadow(
                          color: _C.primary.withOpacity(0.25),
                          blurRadius: 10,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  color: sel ? Colors.white : _C.textSecondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStudentList() {
    final list = _filtered;
    if (list.isEmpty) {
      return const Center(
        child: Text('Tidak ada data', style: TextStyle(color: _C.textHint)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final s = list[i];
        return AnimatedBuilder(
          animation: _entryCtrl,
          builder: (context, child) {
            final anim = CurvedAnimation(
              parent: _entryCtrl,
              curve: Interval(i * 0.06, 1.0, curve: Curves.easeOutCubic),
            );
            return Transform.translate(
              offset: Offset(0, 30 * (1 - anim.value)),
              child: Opacity(opacity: anim.value, child: child),
            );
          },
          child: _buildStudentTile(s),
        );
      },
    );
  }

  Widget _buildStudentTile(_StudentAttendance s) {
    final initials = s.name.split(' ').map((w) => w[0]).take(2).join();
    final statusColor = s.status.color;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.15), width: 1.2),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
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
                  s.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _C.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${s.company} • ${s.position}',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: _C.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  s.status.label,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                s.time,
                style: const TextStyle(
                  fontSize: 12,
                  color: _C.textHint,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate() {
    final now = DateTime.now();
    final days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }
}

// ─── Models ───────────────────────────────────────────────────────────────────
enum _Status {
  hadir('Hadir', Color(0xFF22C55E)),
  terlambat('Terlambat', Color(0xFFF59E0B)),
  izin('Izin', Color(0xFF3B82F6)),
  alpha('Alpha', Color(0xFFEF4444));

  final String label;
  final Color color;
  const _Status(this.label, this.color);
}

class _StudentAttendance {
  final String name, company, position, time;
  final _Status status;
  const _StudentAttendance(
    this.name,
    this.company,
    this.position,
    this.time,
    this.status,
  );
}
