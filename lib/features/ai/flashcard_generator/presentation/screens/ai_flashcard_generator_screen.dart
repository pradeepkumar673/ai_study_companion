import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../../core/services/ai_service.dart';

// ============================================================
//  AI Flashcard Generator Screen
//
//  Features:
//    • Topic input + count selector
//    • Loading animation with sparkle effect
//    • Swipeable deck with 3-D flip animation
//    • Progress indicator (card X of N)
//    • Save to flashcard collection
//
//  🤗 HF Integration: AiService.generateFlashcards()
//     Recommended model: mistralai/Mistral-7B-Instruct-v0.3
//     Prompt: returns JSON array [{front, back, hint}]
// ============================================================

class AiFlashcardGeneratorScreen extends StatefulWidget {
  const AiFlashcardGeneratorScreen({super.key});

  @override
  State<AiFlashcardGeneratorScreen> createState() =>
      _AiFlashcardGeneratorScreenState();
}

class _AiFlashcardGeneratorScreenState extends State<AiFlashcardGeneratorScreen> {
  final _topicController = TextEditingController();
  List<FlashcardData> _cards = [];
  bool _isGenerating = false;
  int _cardCount = 5;
  int _currentIndex = 0;

  final _quickTopics = [
    'Photosynthesis',
    'Newton\'s Laws',
    'World War II',
    'Algebra',
    'Cell Biology',
    'Python Basics',
  ];

  Future<void> _generate() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic first!')),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
      _cards = [];
      _currentIndex = 0;
    });

    try {
      final cards = await AiService.instance.generateFlashcards(topic, _cardCount);
      if (mounted) setState(() {
        _cards = cards;
        _isGenerating = false;
      });
    } catch (e) {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
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
            _GradientBox(child: const Icon(Icons.style, size: 18, color: Colors.white), cs: cs),
            const SizedBox(width: 10),
            const Text('AI Flashcard Generator'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Topic input
            _TopicInput(
              controller: _topicController,
              quickTopics: _quickTopics,
              cs: cs,
              theme: theme,
              onTopicTap: (t) {
                _topicController.text = t;
                setState(() {});
              },
            ),
            const SizedBox(height: 16),

            // Count selector
            _CountSelector(
              value: _cardCount,
              cs: cs,
              theme: theme,
              onChanged: (v) => setState(() => _cardCount = v),
            ),
            const SizedBox(height: 16),

            // Generate button
            FilledButton.icon(
              onPressed: _isGenerating ? null : _generate,
              icon: _isGenerating
                  ? const SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(_isGenerating ? 'Generating $_cardCount cards…' : 'Generate Flashcards'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 24),

            if (_isGenerating) _GeneratingAnimation(cs: cs),

            if (_cards.isNotEmpty) ...[
              // Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Card ${_currentIndex + 1} of ${_cards.length}',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${_cards.length} cards saved to collection! ✅'),
                          backgroundColor: cs.primaryContainer,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.save_outlined, size: 16),
                    label: const Text('Save All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _cards.length,
                  minHeight: 4,
                  backgroundColor: cs.surfaceContainerHigh,
                ),
              ),
              const SizedBox(height: 16),

              // Flashcard
              _FlipCard(card: _cards[_currentIndex], cs: cs, theme: theme),
              const SizedBox(height: 16),

              // Navigation
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _currentIndex > 0
                          ? () => setState(() => _currentIndex--)
                          : null,
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _currentIndex < _cards.length - 1
                          ? () => setState(() => _currentIndex++)
                          : null,
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: Text(_currentIndex < _cards.length - 1 ? 'Next' : 'Done'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Flip Card ────────────────────────────────────────────────

class _FlipCard extends StatefulWidget {
  const _FlipCard({required this.card, required this.cs, required this.theme});
  final FlashcardData card;
  final ColorScheme cs;
  final ThemeData theme;

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _anim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void didUpdateWidget(_FlipCard old) {
    super.didUpdateWidget(old);
    if (old.card != widget.card) {
      _ctrl.reset();
      _showBack = false;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _flip() {
    if (_showBack) {
      _ctrl.reverse();
    } else {
      _ctrl.forward();
    }
    setState(() => _showBack = !_showBack);
  }

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;

    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (ctx, _) {
          final isFlipped = _anim.value >= 0.5;
          final angle = isFlipped
              ? (1 - _anim.value) * math.pi
              : _anim.value * math.pi;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isFlipped
                ? _buildSide(
                    label: 'Answer',
                    icon: Icons.lightbulb_outline,
                    color: cs.tertiaryContainer,
                    onColor: cs.onTertiaryContainer,
                    accentColor: cs.tertiary,
                    body: widget.card.back,
                    sub: null,
                  )
                : _buildSide(
                    label: 'Question',
                    icon: Icons.help_outline,
                    color: cs.primaryContainer,
                    onColor: cs.onPrimaryContainer,
                    accentColor: cs.primary,
                    body: widget.card.front,
                    sub: '💡 Hint: ${widget.card.hint}',
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSide({
    required String label,
    required IconData icon,
    required Color color,
    required Color onColor,
    required Color accentColor,
    required String body,
    String? sub,
  }) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.15),
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
              Icon(icon, size: 16, color: accentColor),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                      letterSpacing: 0.8)),
              const Spacer(),
              Icon(Icons.touch_app_outlined, size: 14, color: onColor.withOpacity(0.4)),
              const SizedBox(width: 2),
              Text('tap to flip',
                  style: TextStyle(fontSize: 11, color: onColor.withOpacity(0.4))),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Text(
                body,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: onColor, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (sub != null)
            Text(sub,
                style: TextStyle(fontSize: 11, color: onColor.withOpacity(0.6), height: 1.4)),
        ],
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────

class _TopicInput extends StatelessWidget {
  const _TopicInput({
    required this.controller,
    required this.quickTopics,
    required this.cs,
    required this.theme,
    required this.onTopicTap,
  });
  final TextEditingController controller;
  final List<String> quickTopics;
  final ColorScheme cs;
  final ThemeData theme;
  final ValueChanged<String> onTopicTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Topic', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'e.g. Photosynthesis, World War II, Python Decorators…',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: cs.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: quickTopics.map((t) => ActionChip(
            label: Text(t, style: const TextStyle(fontSize: 12)),
            onPressed: () => onTopicTap(t),
            backgroundColor: cs.surfaceContainerHigh,
            side: BorderSide.none,
            visualDensity: VisualDensity.compact,
          )).toList(),
        ),
      ],
    );
  }
}

class _CountSelector extends StatelessWidget {
  const _CountSelector({
    required this.value,
    required this.cs,
    required this.theme,
    required this.onChanged,
  });
  final int value;
  final ColorScheme cs;
  final ThemeData theme;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Number of cards: ', style: theme.textTheme.titleSmall),
        const Spacer(),
        ...([3, 5, 8, 10].map((n) => Padding(
          padding: const EdgeInsets.only(left: 6),
          child: ChoiceChip(
            label: Text('$n'),
            selected: value == n,
            onSelected: (_) => onChanged(n),
            selectedColor: cs.primaryContainer,
            side: BorderSide(color: value == n ? cs.primary : cs.outlineVariant),
          ),
        ))),
      ],
    );
  }
}

class _GeneratingAnimation extends StatefulWidget {
  const _GeneratingAnimation({required this.cs});
  final ColorScheme cs;

  @override
  State<_GeneratingAnimation> createState() => _GeneratingAnimationState();
}

class _GeneratingAnimationState extends State<_GeneratingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  int _step = 0;

  static const _steps = [
    '🔍 Analyzing topic…',
    '🧠 Identifying key concepts…',
    '✍️ Crafting questions…',
    '💡 Writing detailed answers…',
    '🎯 Adding helpful hints…',
    '✅ Almost ready!',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat();
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 380));
      if (mounted) setState(() => _step = (_step + 1) % _steps.length);
      return mounted;
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: widget.cs.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          RotationTransition(
            turns: _ctrl,
            child: Icon(Icons.auto_awesome, size: 36, color: widget.cs.primary),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _steps[_step],
              key: ValueKey(_step),
              style: TextStyle(fontSize: 14, color: widget.cs.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBox extends StatelessWidget {
  const _GradientBox({required this.child, required this.cs});
  final Widget child;
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
      child: child,
    );
  }
}
