import 'package:flutter/material.dart';
import '../../../../../core/services/ai_service.dart';

// ============================================================
//  AI Notes Summarizer Screen
//
//  Features:
//    • Paste or type notes → AI generates summary
//    • Key points bullet list
//    • Extracted key terms chips
//    • Compression stats + estimated read time
//    • Shimmer loading skeleton while processing
//
//  🤗 HF Integration: AiService.summarizeNote()
//     Recommended model: facebook/bart-large-cnn
//     Alternative: google/pegasus-xsum (more aggressive compression)
// ============================================================

class AiSummarizerScreen extends StatefulWidget {
  /// Optional: pass a pre-loaded note to summarize on open.
  final String? initialText;
  final String? noteTitle;

  const AiSummarizerScreen({super.key, this.initialText, this.noteTitle});

  @override
  State<AiSummarizerScreen> createState() => _AiSummarizerScreenState();
}

class _AiSummarizerScreenState extends State<AiSummarizerScreen>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  Map<String, dynamic>? _result;
  bool _isLoading = false;
  String? _error;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      _textController.text = widget.initialText!;
    }
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _shimmerAnim = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _summarize() async {
    final text = _textController.text.trim();
    if (text.length < 30) {
      setState(() => _error = 'Please enter at least a few sentences to summarize.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _result = null;
    });

    try {
      final result = await AiService.instance.summarizeNote(text);
      if (mounted) setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() {
        _error = 'Summarization failed. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Row(
          children: [
            _GradientIcon(icon: Icons.auto_awesome, cs: cs),
            const SizedBox(width: 10),
            Text(widget.noteTitle != null
                ? 'Summarize: ${widget.noteTitle}'
                : 'AI Notes Summarizer'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header card
            _InfoCard(cs: cs),
            const SizedBox(height: 16),

            // Input area
            _InputSection(controller: _textController, cs: cs, theme: theme),
            const SizedBox(height: 12),

            if (_error != null)
              _ErrorBanner(error: _error!, cs: cs),

            // Action button
            FilledButton.icon(
              onPressed: _isLoading ? null : _summarize,
              icon: _isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: cs.onPrimary),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(_isLoading ? 'Summarizing…' : 'Summarize with AI'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Results
            if (_isLoading) _ShimmerResult(animation: _shimmerAnim, cs: cs),
            if (_result != null) _ResultSection(result: _result!, cs: cs, theme: theme),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.primaryContainer.withOpacity(0.6),
            cs.tertiaryContainer.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: cs.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              // [HF_API] Model: facebook/bart-large-cnn
              'Powered by AI text summarization • Extracts key concepts instantly',
              style: TextStyle(fontSize: 12, color: cs.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputSection extends StatelessWidget {
  const _InputSection({required this.controller, required this.cs, required this.theme});
  final TextEditingController controller;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Notes', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'Paste your notes here… (lecture notes, textbook excerpts, study material)',
            filled: true,
            fillColor: cs.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outline.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.outline.withOpacity(0.3)),
            ),
          ),
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, __) => Text(
            '${value.text.split(' ').where((w) => w.isNotEmpty).length} words',
            style: TextStyle(fontSize: 11, color: cs.outlineVariant),
          ),
        ),
      ],
    );
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection({required this.result, required this.cs, required this.theme});
  final Map<String, dynamic> result;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Stats row
        Row(
          children: [
            _StatChip(icon: Icons.compress, label: result['compressionRatio'], cs: cs),
            const SizedBox(width: 8),
            _StatChip(icon: Icons.timer_outlined, label: result['readingTime'], cs: cs),
          ],
        ),
        const SizedBox(height: 16),

        // Summary
        _ResultCard(
          icon: Icons.summarize,
          title: 'Summary',
          cs: cs,
          theme: theme,
          child: Text(result['summary'], style: theme.textTheme.bodyMedium?.copyWith(height: 1.6)),
        ),
        const SizedBox(height: 12),

        // Key Points
        _ResultCard(
          icon: Icons.format_list_bulleted,
          title: 'Key Points',
          cs: cs,
          theme: theme,
          child: Column(
            children: (result['keyPoints'] as List<String>).map((p) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.primary,
                    ),
                  ),
                  Expanded(child: Text(p, style: theme.textTheme.bodySmall?.copyWith(height: 1.5))),
                ],
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 12),

        // Key Terms
        _ResultCard(
          icon: Icons.label_outline,
          title: 'Key Terms',
          cs: cs,
          theme: theme,
          child: Wrap(
            spacing: 8,
            runSpacing: 6,
            children: (result['keyTerms'] as List<String>).map((t) => Chip(
              label: Text(t, style: const TextStyle(fontSize: 12)),
              backgroundColor: cs.secondaryContainer,
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
            )).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Save button
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Summary saved to note! ✅'),
                backgroundColor: cs.primaryContainer,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save Summary to Note'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.icon,
    required this.title,
    required this.child,
    required this.cs,
    required this.theme,
  });
  final IconData icon;
  final String title;
  final Widget child;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text(title, style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.primary,
              )),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label, required this.cs});
  final IconData icon;
  final String label;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: cs.secondary),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: cs.onSecondaryContainer)),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.error, required this.cs});
  final String error;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: cs.error, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(error, style: TextStyle(color: cs.onErrorContainer, fontSize: 13))),
        ],
      ),
    );
  }
}

// ── Shimmer skeleton ────────────────────────────────────────

class _ShimmerResult extends StatelessWidget {
  const _ShimmerResult({required this.animation, required this.cs});
  final Animation<double> animation;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (ctx, _) {
        final gradient = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            cs.surfaceContainerHigh,
            cs.surfaceContainerHighest,
            cs.surfaceContainerHigh,
          ],
          stops: const [0.0, 0.5, 1.0],
          transform: GradientRotation(animation.value),
        );
        Widget line(double w, double h) => Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: h,
          width: w == double.infinity ? double.infinity : w,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(6),
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            line(double.infinity, 14),
            line(double.infinity, 14),
            line(200, 14),
            const SizedBox(height: 12),
            line(double.infinity, 14),
            line(double.infinity, 14),
            line(160, 14),
            const SizedBox(height: 12),
            Row(children: [line(80, 28), const SizedBox(width: 8), line(100, 28)]),
          ],
        );
      },
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon({required this.icon, required this.cs});
  final IconData icon;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}
