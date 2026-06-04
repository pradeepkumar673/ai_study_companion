// lib/features/analytics/presentation/widgets/gpa_calculator_widget.dart
//
// StudySpark — GPA / CGPA Calculator
//
// Interactive calculator that lets the user enter subject name, credits, and
// grade point then instantly sees the computed SGPA. Has a "Save to Semester"
// bottom sheet to persist the entries to Isar via GpaEntryModel.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/gpa_entry_model.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../providers/analytics_providers.dart';

// ─── Grade tables ─────────────────────────────────────────────────────────────

const _tenPointGrades = [
  ('O',  10.0),
  ('A+',  9.0),
  ('A',   8.0),
  ('B+',  7.0),
  ('B',   6.0),
  ('C',   5.0),
  ('F',   0.0),
];

const _fourPointGrades = [
  ('A',  4.0),
  ('A-', 3.7),
  ('B+', 3.3),
  ('B',  3.0),
  ('B-', 2.7),
  ('C+', 2.3),
  ('C',  2.0),
  ('D',  1.0),
  ('F',  0.0),
];

// ─── Main widget ──────────────────────────────────────────────────────────────

class GpaCalculatorWidget extends ConsumerStatefulWidget {
  const GpaCalculatorWidget({super.key});

  @override
  ConsumerState<GpaCalculatorWidget> createState() =>
      _GpaCalculatorWidgetState();
}

class _GpaCalculatorWidgetState extends ConsumerState<GpaCalculatorWidget> {
  GradeScale _scale = GradeScale.tenPoint;

  List<(String, double)> get _gradeOptions =>
      _scale == GradeScale.tenPoint ? _tenPointGrades : _fourPointGrades;

  double get _maxScale => _scale == GradeScale.tenPoint ? 10.0 : 4.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final entries = ref.watch(gpaCalculatorProvider);
    final notifier = ref.read(gpaCalculatorProvider.notifier);
    final gpa = notifier.calculatedGPA;
    final grade = _getLetterGrade(gpa);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Scale toggle ─────────────────────────────────────────────
        Row(
          children: GradeScale.values.map((scale) {
            final selected = _scale == scale;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: AnimatedContainer(
                duration: 200.ms,
                child: FilterChip(
                  selected: selected,
                  label: Text(scale.label),
                  onSelected: (_) {
                    setState(() => _scale = scale);
                    // Reset grade points when scale changes
                    for (int i = 0; i < entries.length; i++) {
                      notifier.updateGradePoint(i, 0);
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),
        const Gap(16),

        // ── Result banner ────────────────────────────────────────────
        _GpaBanner(gpa: gpa, grade: grade, maxScale: _maxScale, cs: cs)
            .animate(key: ValueKey(gpa.toStringAsFixed(2)))
            .fadeIn(duration: 200.ms)
            .scale(begin: const Offset(0.96, 0.96)),
        const Gap(16),

        // ── Subject rows ─────────────────────────────────────────────
        ...entries.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _SubjectRow(
              index: entry.key,
              notifier: notifier,
              gradeOptions: _gradeOptions,
              cs: cs,
              isDark: isDark,
            ).animate(delay: Duration(milliseconds: entry.key * 40))
              .fadeIn()
              .slideX(begin: 0.04),
          );
        }),

        // ── Add / Reset buttons ──────────────────────────────────────
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: notifier.add,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Add Subject'),
            ),
            const Gap(8),
            TextButton.icon(
              onPressed: notifier.reset,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Reset'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => _showSaveSheet(context, entries, notifier),
              icon: const Icon(Icons.save_rounded, size: 18),
              label: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }

  String _getLetterGrade(double gpa) {
    final grades = _gradeOptions;
    for (final (letter, point) in grades) {
      if (gpa >= point) return letter;
    }
    return 'F';
  }

  void _showSaveSheet(BuildContext context, List<dynamic> entries,
      GpaCalculatorNotifier notifier) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _SaveSemesterSheet(
        entries: entries,
        notifier: notifier,
        gradeOptions: _gradeOptions,
        scale: _scale,
      ),
    );
  }
}

// ─── GPA Banner ───────────────────────────────────────────────────────────────

class _GpaBanner extends StatelessWidget {
  const _GpaBanner({
    required this.gpa,
    required this.grade,
    required this.maxScale,
    required this.cs,
  });

  final double gpa;
  final String grade;
  final double maxScale;
  final ColorScheme cs;

  Color get _bannerColor {
    final fraction = maxScale == 0 ? 0 : gpa / maxScale;
    if (fraction >= 0.9) return AppColors.chartGreen;
    if (fraction >= 0.7) return AppColors.chartBlue;
    if (fraction >= 0.5) return AppColors.chartAmber;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final color = _bannerColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          // Big GPA number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gpa.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: color,
                  letterSpacing: -1,
                ),
              ),
              Text(
                'GPA / ${maxScale.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
            ],
          ),
          const Spacer(),
          // Grade badge
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.4), width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              grade,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
          const Gap(16),
          // Progress ring
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
               alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: maxScale == 0 ? 0 : (gpa / maxScale).clamp(0, 1),
                  strokeWidth: 6,
                  backgroundColor: color.withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
                Text(
                  '${(maxScale == 0 ? 0 : (gpa / maxScale * 100)).round()}%',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Subject Row ──────────────────────────────────────────────────────────────

class _SubjectRow extends ConsumerWidget {
  const _SubjectRow({
    required this.index,
    required this.notifier,
    required this.gradeOptions,
    required this.cs,
    required this.isDark,
  });

  final int index;
  final GpaCalculatorNotifier notifier;
  final List<(String, double)> gradeOptions;
  final ColorScheme cs;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(gpaCalculatorProvider);
    if (index >= entries.length) return const SizedBox.shrink();

    final entry = entries[index];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppShadows.sm(Colors.black),
      ),
      child: Row(
        children: [
          // Subject name
          Expanded(
            flex: 3,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Subject',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              ),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              onChanged: (v) => notifier.updateSubject(index, v),
            ),
          ),
          const Gap(8),
          // Credits
          SizedBox(
            width: 52,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cr',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(fontSize: 13),
              onChanged: (v) =>
                  notifier.updateCredits(index, int.tryParse(v) ?? 0),
            ),
          ),
          const Gap(8),
          // Grade dropdown
          DropdownButton<double>(
            value: gradeOptions.any((g) => g.$2 == entry.gradePoint)
                ? entry.gradePoint
                : null,
            hint: const Text('Grade', style: TextStyle(fontSize: 12)),
            underline: const SizedBox.shrink(),
            isDense: true,
            items: gradeOptions
                .map((g) => DropdownMenuItem(
                      value: g.$2,
                      child: Text(
                        '${g.$1} (${g.$2.toStringAsFixed(1)})',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) notifier.updateGradePoint(index, v);
            },
          ),
          // Remove button
          IconButton(
            icon: Icon(Icons.remove_circle_outline_rounded,
                size: 18, color: cs.error),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            onPressed: () => notifier.remove(index),
          ),
        ],
      ),
    );
  }
}

// ─── Save Semester Bottom Sheet ───────────────────────────────────────────────

class _SaveSemesterSheet extends ConsumerStatefulWidget {
  const _SaveSemesterSheet({
    required this.entries,
    required this.notifier,
    required this.gradeOptions,
    required this.scale,
  });

  final List<dynamic> entries;
  final GpaCalculatorNotifier notifier;
  final List<(String, double)> gradeOptions;
  final GradeScale scale;

  @override
  ConsumerState<_SaveSemesterSheet> createState() =>
      _SaveSemesterSheetState();
}

class _SaveSemesterSheetState extends ConsumerState<_SaveSemesterSheet> {
  final _semController = TextEditingController(text: 'Semester 1');
  bool _isSaving = false;

  @override
  void dispose() {
    _semController.dispose();
    super.dispose();
  }

  String _letterForGp(double gp) {
    for (final (letter, point) in widget.gradeOptions) {
      if (gp >= point) return letter;
    }
    return 'F';
  }

  Future<void> _save() async {
    if (_semController.text.trim().isEmpty) return;
    setState(() => _isSaving = true);

    final repo = ref.read(analyticsRepositoryProvider);
    final uuid = const Uuid();
    final semLabel = _semController.text.trim();

    for (final entry in widget.entries) {
      if (entry.credits <= 0 || entry.subject.isEmpty) continue;
      final model = GpaEntryModel(
        uuid: uuid.v4(),
        subjectName: entry.subject,
        credits: entry.credits,
        gradePoint: entry.gradePoint,
        letterGrade: _letterForGp(entry.gradePoint),
        semesterLabel: semLabel,
        maxMarks: widget.scale == GradeScale.tenPoint ? 10 : 4,
        marksObtained: entry.gradePoint,
        createdAt: DateTime.now(),
      );
      await repo.saveGpaEntry(model);
    }

    ref.invalidate(semesterBreakdownProvider);
    ref.invalidate(cgpaProvider);
    ref.invalidate(allGpaEntriesProvider);

    setState(() => _isSaving = false);
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved GPA for $semLabel'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(20),
          Text(
            'Save GPA',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const Gap(4),
          Text(
            'Assign a semester label to save these entries permanently.',
            style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
          ),
          const Gap(20),
          TextField(
            controller: _semController,
            decoration: const InputDecoration(
              labelText: 'Semester Label',
              hintText: 'e.g. Semester 3 or Fall 2025',
            ),
          ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save Entries'),
            ),
          ),
        ],
      ),
    );
  }
}
