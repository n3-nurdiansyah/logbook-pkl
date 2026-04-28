// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class _C {
  static const primary = Color(0xFF16A34A);
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

class HistoryAbsensiScreen extends StatefulWidget {
  const HistoryAbsensiScreen({Key? key}) : super(key: key);

  @override
  State<HistoryAbsensiScreen> createState() => _HistoryAbsensiScreenState();
}

class _HistoryAbsensiScreenState extends State<HistoryAbsensiScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  String _selectedStudent = 'Semua Siswa';
  int _selectedMonth = DateTime.now().month;

  final _students = [
    'Semua Siswa',
    'Budi Santoso',
    'Rina Putri',
    'Doni Rahmat',
    'Siti Aisyah',
  ];

  final _months = [
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

  final _history = [
    _HistoryEntry(
      'Budi Santoso',
      '28 Apr 2025',
      '07:52',
      '16:30',
      'Hadir',
      Colors.green,
    ),
    _HistoryEntry(
      'Rina Putri',
      '28 Apr 2025',
      '08:05',
      '16:45',
      'Hadir',
      Colors.green,
    ),
    _HistoryEntry(
      'Doni Rahmat',
      '28 Apr 2025',
      '09:10',
      '16:30',
      'Terlambat',
      Color(0xFFF59E0B),
    ),
    _HistoryEntry(
      'Siti Aisyah',
      '28 Apr 2025',
      '-',
      '-',
      'Izin',
      Color(0xFF3B82F6),
    ),
    _HistoryEntry(
      'Budi Santoso',
      '27 Apr 2025',
      '07:48',
      '16:30',
      'Hadir',
      Colors.green,
    ),
    _HistoryEntry(
      'Rina Putri',
      '27 Apr 2025',
      '07:55',
      '16:50',
      'Hadir',
      Colors.green,
    ),
    _HistoryEntry(
      'Doni Rahmat',
      '27 Apr 2025',
      '07:58',
      '16:30',
      'Hadir',
      Colors.green,
    ),
    _HistoryEntry(
      'Siti Aisyah',
      '27 Apr 2025',
      '-',
      '-',
      'Alpha',
      Color(0xFFEF4444),
    ),
    _HistoryEntry(
      'Budi Santoso',
      '26 Apr 2025',
      '08:15',
      '16:30',
      'Terlambat',
      Color(0xFFF59E0B),
    ),
    _HistoryEntry(
      'Rina Putri',
      '26 Apr 2025',
      '07:50',
      '16:30',
      'Hadir',
      Colors.green,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Map<String, List<_HistoryEntry>> get _grouped {
    final filtered = _selectedStudent == 'Semua Siswa'
        ? _history
        : _history.where((h) => h.studentName == _selectedStudent).toList();
    final map = <String, List<_HistoryEntry>>{};
    for (final h in filtered) {
      map.putIfAbsent(h.date, () => []).add(h);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildMonthScroll(),
            _buildStudentDropdown(),
            _buildSummaryChips(),
            Expanded(child: _buildGroupedList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: _C.primary.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riwayat Absensi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _C.textPrimary,
                  ),
                ),
                Text(
                  'PKL Tahun 2025',
                  style: TextStyle(
                    fontSize: 12,
                    color: _C.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _C.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              LucideIcons.download,
              color: _C.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthScroll() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (_, i) {
          final sel = _selectedMonth == i + 1;
          return GestureDetector(
            onTap: () => setState(() => _selectedMonth = i + 1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
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
                _months[i],
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

  Widget _buildStudentDropdown() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.cardBorder, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStudent,
          isExpanded: true,
          icon: const Icon(
            LucideIcons.chevronsUpDown,
            color: _C.primary,
            size: 18,
          ),
          style: const TextStyle(
            fontSize: 14,
            color: _C.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (v) => setState(() => _selectedStudent = v!),
          items: _students
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSummaryChips() {
    final all = _history;
    final hadir = all.where((h) => h.status == 'Hadir').length;
    final terlambat = all.where((h) => h.status == 'Terlambat').length;
    final izin = all.where((h) => h.status == 'Izin').length;
    final alpha = all.where((h) => h.status == 'Alpha').length;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _C.cardBorder, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _chip('$hadir', 'Hadir', _C.success),
          _chip('$terlambat', 'Terlambat', _C.warning),
          _chip('$izin', 'Izin', _C.info),
          _chip('$alpha', 'Alpha', _C.danger),
        ],
      ),
    );
  }

  Widget _chip(String val, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              val,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _C.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupedList() {
    final grouped = _grouped;
    if (grouped.isEmpty) {
      return const Center(
        child: Text('Tidak ada riwayat', style: TextStyle(color: _C.textHint)),
      );
    }
    final dates = grouped.keys.toList();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      itemCount: dates.length,
      itemBuilder: (_, di) {
        final date = dates[di];
        final entries = grouped[date]!;
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (context, child) {
            final anim = CurvedAnimation(
              parent: _ctrl,
              curve: Interval(di * 0.1, 1.0, curve: Curves.easeOutCubic),
            );
            return Transform.translate(
              offset: Offset(0, 20 * (1 - anim.value)),
              child: Opacity(opacity: anim.value, child: child),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 4),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: _C.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _C.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Container(height: 1, color: _C.cardBorder)),
                  ],
                ),
              ),
              ...entries.map((e) => _buildEntryTile(e)),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEntryTile(_HistoryEntry e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: e.statusColor.withOpacity(0.15), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: e.statusColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                e.studentName.split(' ').map((w) => w[0]).take(2).join(),
                style: TextStyle(
                  color: e.statusColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.studentName,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: _C.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(LucideIcons.logIn, size: 12, color: _C.textHint),
                    const SizedBox(width: 4),
                    Text(
                      e.timeIn,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _C.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      LucideIcons.logOut,
                      size: 12,
                      color: _C.textHint,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      e.timeOut,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: _C.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: e.statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              e.status,
              style: TextStyle(
                color: e.statusColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryEntry {
  final String studentName, date, timeIn, timeOut, status;
  final Color statusColor;
  const _HistoryEntry(
    this.studentName,
    this.date,
    this.timeIn,
    this.timeOut,
    this.status,
    this.statusColor,
  );
}
