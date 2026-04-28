// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

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

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({Key? key}) : super(key: key);

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  String _selectedType = 'Rekap Bulanan';
  String _selectedStudent = 'Semua Siswa';
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = 2025;
  String _format = 'PDF';
  bool _isGenerating = false;

  final _reportTypes = [
    _ReportType(
      'Rekap Bulanan',
      LucideIcons.calendarDays,
      _C.primary,
      'Rekap kehadiran per bulan',
    ),
    _ReportType(
      'Rekap Per Siswa',
      LucideIcons.userCheck,
      _C.info,
      'Detail kehadiran tiap siswa',
    ),
    _ReportType(
      'Rekap Per Perusahaan',
      LucideIcons.building2,
      _C.warning,
      'Laporan berdasarkan tempat PKL',
    ),
    _ReportType(
      'Laporan Akhir PKL',
      LucideIcons.fileSpreadsheet,
      _C.danger,
      'Laporan komprehensif akhir PKL',
    ),
  ];

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

  final _previousReports = [
    _ReportItem('Rekap Bulanan - Maret 2025', '5 Apr 2025', 'PDF', '2.4 MB'),
    _ReportItem('Rekap Per Siswa - Feb 2025', '3 Mar 2025', 'Excel', '1.8 MB'),
    _ReportItem('Laporan Akhir PKL - Jan 2025', '1 Feb 2025', 'PDF', '4.2 MB'),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Jenis Laporan', 0),
                    const SizedBox(height: 12),
                    _buildReportTypeGrid(),
                    const SizedBox(height: 24),
                    _sectionTitle('Filter', 0.2),
                    const SizedBox(height: 12),
                    _buildFilterSection(),
                    const SizedBox(height: 24),
                    _sectionTitle('Format Ekspor', 0.35),
                    const SizedBox(height: 12),
                    _buildFormatSelector(),
                    const SizedBox(height: 24),
                    _buildPreviewCard(),
                    const SizedBox(height: 24),
                    _buildGenerateButton(),
                    const SizedBox(height: 28),
                    _sectionTitle('Laporan Sebelumnya', 0.5),
                    const SizedBox(height: 12),
                    _buildPreviousReports(),
                  ],
                ),
              ),
            ),
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
                  'Buat Laporan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _C.textPrimary,
                  ),
                ),
                Text(
                  'Generate & ekspor laporan PKL',
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
            child: const Icon(LucideIcons.history, color: _C.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, double delay) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) {
        final anim = CurvedAnimation(
          parent: _ctrl,
          curve: Interval(delay, delay + 0.5, curve: Curves.easeOutCubic),
        );
        return Opacity(opacity: anim.value, child: child);
      },
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: _C.textPrimary,
        ),
      ),
    );
  }

  Widget _buildReportTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: _reportTypes.length,
      itemBuilder: (_, i) {
        final rt = _reportTypes[i];
        final sel = _selectedType == rt.title;
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) {
            final anim = CurvedAnimation(
              parent: _ctrl,
              curve: Interval(0.05 + i * 0.07, 1.0, curve: Curves.easeOutBack),
            );
            return Transform.scale(
              scale: Tween<double>(begin: 0.7, end: 1.0).evaluate(anim),
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () => setState(() => _selectedType = rt.title),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: sel ? rt.color.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: sel ? rt.color : _C.cardBorder,
                  width: sel ? 2 : 1.2,
                ),
                boxShadow: sel
                    ? [
                        BoxShadow(
                          color: rt.color.withOpacity(0.18),
                          blurRadius: 16,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: rt.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(rt.icon, color: rt.color, size: 20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rt.title,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: sel ? rt.color : _C.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        rt.subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          color: _C.textHint,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSection() {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) {
        final anim = CurvedAnimation(
          parent: _ctrl,
          curve: const Interval(0.25, 0.85, curve: Curves.easeOutCubic),
        );
        return Transform.translate(
          offset: Offset(0, 20 * (1 - anim.value)),
          child: Opacity(opacity: anim.value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _C.cardBorder, width: 1.2),
        ),
        child: Column(
          children: [
            // Student dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: _C.bg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _C.cardBorder),
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
                    fontSize: 13,
                    color: _C.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (v) => setState(() => _selectedStudent = v!),
                  items: _students
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Month
            SizedBox(
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (_, i) {
                  final sel = _selectedMonth == i + 1;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMonth = i + 1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? _C.primary : _C.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: sel ? _C.primary : _C.cardBorder,
                        ),
                      ),
                      child: Text(
                        _months[i],
                        style: TextStyle(
                          color: sel ? Colors.white : _C.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Year
            Row(
              children: [
                const Text(
                  'Tahun:',
                  style: TextStyle(
                    color: _C.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                ...[2023, 2024, 2025].map((y) {
                  final sel = _selectedYear == y;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedYear = y),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: sel ? _C.primary : _C.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: sel ? _C.primary : _C.cardBorder,
                        ),
                      ),
                      child: Text(
                        '$y',
                        style: TextStyle(
                          color: sel ? Colors.white : _C.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatSelector() {
    final formats = [
      ('PDF', LucideIcons.fileText, _C.danger),
      ('Excel', LucideIcons.fileSpreadsheet, _C.success),
      ('CSV', LucideIcons.fileCode, _C.info),
    ];
    return Row(
      children: formats.map((f) {
        final sel = _format == f.$1;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _format = f.$1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: f.$1 != 'CSV' ? 10 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: sel ? f.$3.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: sel ? f.$3 : _C.cardBorder,
                  width: sel ? 2 : 1.2,
                ),
                boxShadow: sel
                    ? [BoxShadow(color: f.$3.withOpacity(0.15), blurRadius: 12)]
                    : [],
              ),
              child: Column(
                children: [
                  Icon(f.$2, color: sel ? f.$3 : _C.textHint, size: 24),
                  const SizedBox(height: 6),
                  Text(
                    f.$1,
                    style: TextStyle(
                      color: sel ? f.$3 : _C.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_C.primarySoft, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _C.cardBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _C.primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.eye, color: _C.primary, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Preview Laporan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: _C.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _previewRow('Jenis', _selectedType),
          _previewRow('Siswa', _selectedStudent),
          _previewRow(
            'Periode',
            '${_months[_selectedMonth - 1]} $_selectedYear',
          ),
          _previewRow('Format', _format),
        ],
      ),
    );
  }

  Widget _previewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: _C.textHint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(color: _C.textHint)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: _C.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    return GestureDetector(
      onTap: () async {
        setState(() => _isGenerating = true);
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() => _isGenerating = false);
          _showSuccessSnack();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isGenerating
                ? [const Color(0xFF6B7280), const Color(0xFF4B5563)]
                : [const Color(0xFF22C55E), const Color(0xFF15803D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (_isGenerating ? Colors.grey : _C.primary).withOpacity(
                0.35,
              ),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: _isGenerating
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Membuat Laporan...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.download, color: Colors.white, size: 22),
                  SizedBox(width: 10),
                  Text(
                    'Generate & Unduh Laporan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPreviousReports() {
    return Column(
      children: _previousReports.asMap().entries.map((e) {
        final r = e.value;
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) {
            final anim = CurvedAnimation(
              parent: _ctrl,
              curve: Interval(
                0.5 + e.key * 0.08,
                1.0,
                curve: Curves.easeOutCubic,
              ),
            );
            return Transform.translate(
              offset: Offset(0, 20 * (1 - anim.value)),
              child: Opacity(opacity: anim.value, child: child),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _C.cardBorder, width: 1.2),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: r.format == 'PDF'
                        ? _C.danger.withOpacity(0.1)
                        : _C.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    r.format == 'PDF'
                        ? LucideIcons.fileText
                        : LucideIcons.fileSpreadsheet,
                    color: r.format == 'PDF' ? _C.danger : _C.success,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _C.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${r.date} • ${r.size}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: _C.textHint,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _C.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    LucideIcons.download,
                    color: _C.primary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showSuccessSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.checkCircle2,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Laporan berhasil dibuat!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: _C.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _ReportType {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  const _ReportType(this.title, this.icon, this.color, this.subtitle);
}

class _ReportItem {
  final String title, date, format, size;
  const _ReportItem(this.title, this.date, this.format, this.size);
}
