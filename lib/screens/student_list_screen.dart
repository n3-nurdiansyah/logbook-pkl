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
  static const danger = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
  static const bg = Color(0xFFF8FFF9);
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _search = TextEditingController();
  String _query = '';

  final List<_Student> _students = [
    _Student(
      '1',
      'Budi Santoso',
      'budi@email.com',
      'Siswa',
      'PT. Maju Bersama',
      'Jl. Sudirman No.1',
      'Backend Developer',
    ),
    _Student(
      '2',
      'Rina Putri',
      'rina@email.com',
      'Siswa',
      'CV. Digital Nusa',
      'Jl. Gatot Subroto No.5',
      'UI/UX Designer',
    ),
    _Student(
      '3',
      'Doni Rahmat',
      'doni@email.com',
      'Siswa',
      'PT. Solusi IT',
      'Jl. Thamrin No.10',
      'Frontend Developer',
    ),
    _Student(
      '4',
      'Siti Aisyah',
      'siti@email.com',
      'Siswa',
      'PT. TechnoInd',
      'Jl. Kuningan No.3',
      'Data Analyst',
    ),
    _Student(
      '5',
      'Fajar Kurnia',
      'fajar@email.com',
      'Siswa',
      'CV. Kreasi Digital',
      'Jl. Rasuna Said No.8',
      'Mobile Developer',
    ),
    _Student(
      '6',
      'Dewi Lestari',
      'dewi@email.com',
      'Siswa',
      'PT. Maju Bersama',
      'Jl. Sudirman No.1',
      'QA Tester',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _search.addListener(
      () => setState(() => _query = _search.text.toLowerCase()),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _search.dispose();
    super.dispose();
  }

  List<_Student> get _filtered => _students
      .where(
        (s) =>
            s.name.toLowerCase().contains(_query) ||
            s.email.toLowerCase().contains(_query) ||
            s.company.toLowerCase().contains(_query),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            Expanded(child: _buildList()),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      color: Colors.white,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Siswa PKL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _C.textPrimary,
                  ),
                ),
                Text(
                  '${_students.length} siswa terdaftar',
                  style: const TextStyle(
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
            child: const Icon(LucideIcons.filter, color: _C.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.cardBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _search,
        style: const TextStyle(fontSize: 14, color: _C.textPrimary),
        decoration: const InputDecoration(
          hintText: 'Cari nama, email, atau perusahaan...',
          hintStyle: TextStyle(color: _C.textHint, fontSize: 13),
          prefixIcon: Icon(LucideIcons.search, color: _C.textHint, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildList() {
    final list = _filtered;
    if (list.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.searchX, color: _C.textHint, size: 48),
            SizedBox(height: 12),
            Text(
              'Siswa tidak ditemukan',
              style: TextStyle(color: _C.textHint, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final s = list[i];
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (context, child) {
            final anim = CurvedAnimation(
              parent: _ctrl,
              curve: Interval(i * 0.08, 1.0, curve: Curves.easeOutCubic),
            );
            return Transform.translate(
              offset: Offset(0, 30 * (1 - anim.value)),
              child: Opacity(opacity: anim.value, child: child),
            );
          },
          child: _buildStudentCard(s),
        );
      },
    );
  }

  Widget _buildStudentCard(_Student s) {
    final initials = s.name.split(' ').map((w) => w[0]).take(2).join();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _C.cardBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF22C55E), Color(0xFF15803D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _C.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
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
                        s.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _C.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        s.email,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _C.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _C.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    s.role,
                    style: const TextStyle(
                      color: _C.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info rows
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _C.bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                _infoRow(LucideIcons.building2, s.company),
                const SizedBox(height: 6),
                _infoRow(LucideIcons.briefcase, s.jobPosition),
                const SizedBox(height: 6),
                _infoRow(LucideIcons.mapPin, s.companyAddress),
              ],
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StudentFormScreen(student: s),
                      ),
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: _C.primarySoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.pencil, color: _C.primary, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Edit',
                            style: TextStyle(
                              color: _C.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _confirmDelete(s),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      LucideIcons.trash2,
                      color: _C.danger,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: _C.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: _C.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFAB() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<_Student>(
          context,
          MaterialPageRoute(builder: (_) => const StudentFormScreen()),
        );
        if (result != null) {
          setState(() => _students.add(result));
        }
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF22C55E), Color(0xFF15803D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _C.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.userPlus, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'Tambah Siswa',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(_Student s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.trash2, color: _C.danger, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              'Hapus ${s.name}?',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: _C.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Data siswa ini akan dihapus secara permanen.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: _C.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: _C.bg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _C.cardBorder),
                      ),
                      child: const Center(
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _C.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _students.remove(s));
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: _C.danger,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          'Hapus',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Student Model ────────────────────────────────────────────────────────────
class _Student {
  final String id, name, email, role, company, companyAddress, jobPosition;
  const _Student(
    this.id,
    this.name,
    this.email,
    this.role,
    this.company,
    this.companyAddress,
    this.jobPosition,
  );
}

// ─── Student Form Screen ──────────────────────────────────────────────────────
class StudentFormScreen extends StatefulWidget {
  final _Student? student;
  const StudentFormScreen({Key? key, this.student}) : super(key: key);

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _company;
  late final TextEditingController _address;
  late final TextEditingController _position;
  String _role = 'Siswa';

  bool get _isEdit => widget.student != null;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    final s = widget.student;
    _name = TextEditingController(text: s?.name ?? '');
    _email = TextEditingController(text: s?.email ?? '');
    _company = TextEditingController(text: s?.company ?? '');
    _address = TextEditingController(text: s?.companyAddress ?? '');
    _position = TextEditingController(text: s?.jobPosition ?? '');
    _role = s?.role ?? 'Siswa';
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _name.dispose();
    _email.dispose();
    _company.dispose();
    _address.dispose();
    _position.dispose();
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
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildAvatar(),
                      const SizedBox(height: 24),
                      _field('Nama Lengkap', _name, LucideIcons.user, 0),
                      const SizedBox(height: 14),
                      _field(
                        'Email',
                        _email,
                        LucideIcons.mail,
                        0.06,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),
                      _roleSelector(0.12),
                      const SizedBox(height: 14),
                      _field(
                        'Nama Perusahaan',
                        _company,
                        LucideIcons.building2,
                        0.18,
                      ),
                      const SizedBox(height: 14),
                      _field(
                        'Alamat Perusahaan',
                        _address,
                        LucideIcons.mapPin,
                        0.24,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 14),
                      _field(
                        'Posisi / Job Position',
                        _position,
                        LucideIcons.briefcase,
                        0.30,
                      ),
                      const SizedBox(height: 32),
                      _buildSaveButton(),
                    ],
                  ),
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
      color: Colors.white,
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
          Text(
            _isEdit ? 'Edit Data Siswa' : 'Tambah Siswa Baru',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: _C.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final initials = _name.text.trim().isEmpty
        ? '??'
        : _name.text
              .trim()
              .split(' ')
              .map((w) => w[0])
              .take(2)
              .join()
              .toUpperCase();
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Transform.scale(
        scale: CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack).value,
        child: child,
      ),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF22C55E), Color(0xFF15803D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _C.primary.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl,
    IconData icon,
    double delay, {
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final anim = CurvedAnimation(
          parent: _ctrl,
          curve: Interval(delay, delay + 0.6, curve: Curves.easeOutCubic),
        );
        return Transform.translate(
          offset: Offset(0, 20 * (1 - anim.value)),
          child: Opacity(opacity: anim.value, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _C.cardBorder, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: ctrl,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14,
            color: _C.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          validator: (v) =>
              (v == null || v.isEmpty) ? '$label tidak boleh kosong' : null,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: _C.textSecondary, fontSize: 13),
            prefixIcon: Icon(icon, color: _C.primary, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: _C.primary, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleSelector(double delay) {
    final roles = ['Siswa', 'Magang', 'PKL'];
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) {
        final anim = CurvedAnimation(
          parent: _ctrl,
          curve: Interval(delay, delay + 0.6, curve: Curves.easeOutCubic),
        );
        return Transform.translate(
          offset: Offset(0, 20 * (1 - anim.value)),
          child: Opacity(opacity: anim.value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _C.cardBorder, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.userCog, color: _C.primary, size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Role',
                  style: TextStyle(color: _C.textSecondary, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: roles.map((r) {
                final sel = _role == r;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _role = r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(right: r != roles.last ? 8 : 0),
                      height: 40,
                      decoration: BoxDecoration(
                        color: sel ? _C.primary : _C.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: sel ? _C.primary : _C.cardBorder,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          r,
                          style: TextStyle(
                            color: sel ? Colors.white : _C.textSecondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          final student = _Student(
            DateTime.now().toString(),
            _name.text,
            _email.text,
            _role,
            _company.text,
            _address.text,
            _position.text,
          );
          Navigator.pop(context, student);
        }
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF22C55E), Color(0xFF15803D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _C.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isEdit ? LucideIcons.save : LucideIcons.userPlus,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              _isEdit ? 'Simpan Perubahan' : 'Tambah Siswa',
              style: const TextStyle(
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
}
