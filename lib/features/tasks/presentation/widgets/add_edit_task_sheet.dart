// lib/features/tasks/presentation/widgets/add_edit_task_sheet.dart
//
// StudySpark — Add / Edit Task Bottom Sheet (Step 5)
//
// Full form with:
//   • Title + description
//   • Priority selector (4 levels)
//   • Deadline date+time picker
//   • Reminder toggle + time offset picker
//   • Subject tag dropdown
//   • Repeat frequency selector
//   • Subtask quick-add list
//   • Estimated minutes slider
//   • Save → creates/updates task + schedules notification
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/app_enums.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../data/models/subtask_model.dart';
import '../../data/models/task_model.dart';

const _uuid = Uuid();

// ─── Sheet ────────────────────────────────────────────────────────────────────

class AddEditTaskSheet extends ConsumerStatefulWidget {
  const AddEditTaskSheet({super.key, this.existingTask});

  final TaskModel? existingTask;

  @override
  ConsumerState<AddEditTaskSheet> createState() => _AddEditTaskSheetState();
}

class _AddEditTaskSheetState extends ConsumerState<AddEditTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _subtaskCtrl = TextEditingController();

  Priority _priority = Priority.medium;
  DateTime? _deadline;
  bool _enableReminder = false;
  Duration _reminderOffset = const Duration(hours: 1);
  RepeatFrequency _repeat = RepeatFrequency.none;
  int _estimatedMinutes = 30;
  final List<SubtaskModel> _subtasks = [];
  bool _saving = false;

  bool get _isEdit => widget.existingTask != null;

  @override
  void initState() {
    super.initState();
    final t = widget.existingTask;
    if (t != null) {
      _titleCtrl.text = t.title;
      _descCtrl.text = t.description;
      _priority = t.priority;
      _deadline = t.deadline;
      _repeat = t.repeatFrequency;
      _estimatedMinutes = t.estimatedMinutes;
      _subtasks.addAll(t.subtasks);
      if (t.reminderAt != null) {
        _enableReminder = true;
        _reminderOffset = t.deadline != null
            ? t.deadline!.difference(t.reminderAt!)
            : const Duration(hours: 1);
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _subtaskCtrl.dispose();
    super.dispose();
  }

  // ── Deadline picker ──────────────────────────────────────────────────────

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now.add(const Duration(days: 1)),
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline ?? now),
    );
    if (!mounted) return;
    setState(() {
      _deadline = DateTime(
        date.year, date.month, date.day,
        time?.hour ?? 23, time?.minute ?? 59,
      );
    });
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);

    final repo = ref.read(taskRepositoryProvider);
    final ns = ref.read(notificationServiceProvider);

    // Compute reminder time
    DateTime? reminderAt;
    int? notifId;
    if (_enableReminder && _deadline != null) {
      reminderAt = _deadline!.subtract(_reminderOffset);
      notifId = widget.existingTask?.notificationId ?? notificationId();
      if (reminderAt.isAfter(DateTime.now())) {
        await ns.scheduleReminder(
          id: notifId,
          title: '⏰ Reminder: ${_titleCtrl.text.trim()}',
          body: _deadline != null
              ? 'Due ${DateFormat('EEE d MMM, h:mm a').format(_deadline!.toLocal())}'
              : 'Your task is coming up!',
          scheduledAt: reminderAt,
          payload: 'task:${widget.existingTask?.uuid ?? ''}',
        );
      }
    }

    if (_isEdit) {
      final updated = widget.existingTask!
        ..title = _titleCtrl.text.trim()
        ..description = _descCtrl.text.trim()
        ..priority = _priority
        ..deadline = _deadline?.toUtc()
        ..repeatFrequency = _repeat
        ..estimatedMinutes = _estimatedMinutes
        ..subtasks = List.from(_subtasks)
        ..reminderAt = reminderAt?.toUtc()
        ..notificationId = notifId;
      await repo.updateTask(updated);
    } else {
      await repo.createTask(
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        priority: _priority,
        deadline: _deadline?.toUtc(),
        repeatFrequency: _repeat,
        estimatedMinutes: _estimatedMinutes,
        subtasks: List.from(_subtasks),
        reminderAt: reminderAt?.toUtc(),
        notificationId: notifId,
      );
    }

    if (!mounted) return;
    setState(() => _saving = false);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEdit ? 'Task updated!' : 'Task created! 🎉'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, mq.viewInsets.bottom),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36, height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    _isEdit ? 'Edit Task' : 'New Task',
                    style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  if (_isEdit)
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(taskRepositoryProvider)
                            .deleteTask(widget.existingTask!.uuid);
                        if (mounted) Navigator.of(context).pop();
                      },
                      child: Text('Delete',
                          style: TextStyle(color: cs.error)),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Scrollable form
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    TextFormField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Task title *',
                        prefixIcon: Icon(Icons.task_alt_rounded),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Title is required' : null,
                    ),
                    const SizedBox(height: 12),

                    // Description
                    TextFormField(
                      controller: _descCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Description (optional)',
                        prefixIcon: Icon(Icons.notes_rounded),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20),

                    // Priority
                    _SectionLabel(label: 'Priority'),
                    const SizedBox(height: 8),
                    _PriorityPicker(
                      selected: _priority,
                      onChanged: (p) => setState(() => _priority = p),
                    ),
                    const SizedBox(height: 20),

                    // Deadline
                    _SectionLabel(label: 'Deadline'),
                    const SizedBox(height: 8),
                    _DeadlineTile(
                      deadline: _deadline,
                      onTap: _pickDeadline,
                      onClear: () => setState(() => _deadline = null),
                    ),
                    const SizedBox(height: 16),

                    // Reminder
                    if (_deadline != null) ...[
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Set Reminder'),
                        subtitle: _enableReminder
                            ? _ReminderOffsetPicker(
                                offset: _reminderOffset,
                                onChanged: (d) =>
                                    setState(() => _reminderOffset = d),
                              )
                            : Text('Get notified before the deadline',
                                style: TextStyle(
                                    color: cs.onSurfaceVariant, fontSize: 12)),
                        secondary: Icon(Icons.notifications_rounded,
                            color: _enableReminder ? cs.primary : cs.outline),
                        value: _enableReminder,
                        onChanged: (v) => setState(() => _enableReminder = v),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // Estimated time
                    _SectionLabel(label: 'Estimated time: $_estimatedMinutes min'),
                    Slider(
                      min: 15, max: 180,
                      divisions: 11,
                      value: _estimatedMinutes.toDouble(),
                      label: '$_estimatedMinutes min',
                      onChanged: (v) =>
                          setState(() => _estimatedMinutes = v.round()),
                    ),

                    const SizedBox(height: 8),

                    // Repeat
                    _SectionLabel(label: 'Repeat'),
                    const SizedBox(height: 8),
                    _RepeatPicker(
                      selected: _repeat,
                      onChanged: (r) => setState(() => _repeat = r),
                    ),
                    const SizedBox(height: 20),

                    // Subtasks
                    _SectionLabel(label: 'Subtasks'),
                    const SizedBox(height: 8),
                    _SubtaskList(
                      subtasks: _subtasks,
                      controller: _subtaskCtrl,
                      onAdd: (title) {
                        setState(() {
                          _subtasks.add(SubtaskModel(
                            id: _uuid.v4(),
                            title: title,
                            position: _subtasks.length,
                            createdAt: DateTime.now().toUtc(),
                          ));
                        });
                        _subtaskCtrl.clear();
                      },
                      onToggle: (id) {
                        setState(() {
                          final idx =
                              _subtasks.indexWhere((s) => s.id == id);
                          if (idx != -1) {
                            _subtasks[idx].isCompleted =
                                !_subtasks[idx].isCompleted;
                          }
                        });
                      },
                      onRemove: (id) {
                        setState(() =>
                            _subtasks.removeWhere((s) => s.id == id));
                      },
                    ),

                    const SizedBox(height: 24),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: _saving ? null : _save,
                        child: _saving
                            ? const SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Text(_isEdit ? 'Save Changes' : 'Create Task'),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 0.1, duration: 300.ms, curve: Curves.easeOutCubic);
  }
}

// ─── Priority picker ──────────────────────────────────────────────────────────

class _PriorityPicker extends StatelessWidget {
  const _PriorityPicker({required this.selected, required this.onChanged});

  final Priority selected;
  final ValueChanged<Priority> onChanged;

  static Color _color(Priority p, ColorScheme cs) => switch (p) {
        Priority.critical => cs.error,
        Priority.high   => const Color(0xFFE65100),
        Priority.medium => cs.primary,
        Priority.low    => cs.tertiary,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: Priority.values.map((p) {
        final isSelected = p == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(p),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? _color(p, cs).withOpacity(0.15)
                    : cs.surfaceContainerHighest,
                borderRadius: AppShapes.r12,
                border: Border.all(
                  color: isSelected ? _color(p, cs) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: _color(p, cs),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.label,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: isSelected ? _color(p, cs) : cs.onSurfaceVariant,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w400,
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
}

// ─── Deadline tile ────────────────────────────────────────────────────────────

class _DeadlineTile extends StatelessWidget {
  const _DeadlineTile({
    required this.deadline,
    required this.onTap,
    required this.onClear,
  });

  final DateTime? deadline;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasDeadline = deadline != null;
    return InkWell(
      onTap: onTap,
      borderRadius: AppShapes.r12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: hasDeadline
              ? cs.primaryContainer.withOpacity(0.4)
              : cs.surfaceContainerHighest,
          borderRadius: AppShapes.r12,
          border: Border.all(
            color: hasDeadline ? cs.primary.withOpacity(0.4) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: hasDeadline ? cs.primary : cs.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                hasDeadline
                    ? DateFormat('EEE, d MMM yyyy  •  h:mm a')
                        .format(deadline!.toLocal())
                    : 'Set deadline (optional)',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: hasDeadline ? cs.onSurface : cs.onSurfaceVariant,
                    ),
              ),
            ),
            if (hasDeadline)
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close_rounded, color: cs.outline, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Reminder offset picker ───────────────────────────────────────────────────

class _ReminderOffsetPicker extends StatelessWidget {
  const _ReminderOffsetPicker({required this.offset, required this.onChanged});

  final Duration offset;
  final ValueChanged<Duration> onChanged;

  static const _options = [
    (label: '15 min', duration: Duration(minutes: 15)),
    (label: '30 min', duration: Duration(minutes: 30)),
    (label: '1 hour', duration: Duration(hours: 1)),
    (label: '3 hours', duration: Duration(hours: 3)),
    (label: '1 day', duration: Duration(days: 1)),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _options.map((o) {
        final sel = offset == o.duration;
        return ChoiceChip(
          label: Text(o.label),
          selected: sel,
          onSelected: (_) => onChanged(o.duration),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        );
      }).toList(),
    );
  }
}

// ─── Repeat picker ────────────────────────────────────────────────────────────

class _RepeatPicker extends StatelessWidget {
  const _RepeatPicker({required this.selected, required this.onChanged});

  final RepeatFrequency selected;
  final ValueChanged<RepeatFrequency> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: RepeatFrequency.values.map((r) {
        return ChoiceChip(
          label: Text(r.label),
          selected: r == selected,
          onSelected: (_) => onChanged(r),
        );
      }).toList(),
    );
  }
}

// ─── Subtask list ─────────────────────────────────────────────────────────────

class _SubtaskList extends StatelessWidget {
  const _SubtaskList({
    required this.subtasks,
    required this.controller,
    required this.onAdd,
    required this.onToggle,
    required this.onRemove,
  });

  final List<SubtaskModel> subtasks;
  final TextEditingController controller;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        // Existing subtasks
        for (final s in subtasks)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
              value: s.isCompleted,
              onChanged: (_) => onToggle(s.id),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            title: Text(
              s.title,
              style: s.isCompleted
                  ? TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: cs.onSurfaceVariant,
                    )
                  : null,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded, size: 18),
              onPressed: () => onRemove(s.id),
            ),
          ).animate().fadeIn(),

        // Add input
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Add a subtask…',
                  prefixIcon: Icon(Icons.add_rounded, size: 20),
                ),
                onSubmitted: (v) {
                  if (v.trim().isNotEmpty) onAdd(v.trim());
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              icon: const Icon(Icons.check_rounded),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  onAdd(controller.text.trim());
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Section label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

// ─── Helper: generate notification id ─────────────────────────────────────────
int notificationId() => DateTime.now().millisecondsSinceEpoch ~/ 1000;
