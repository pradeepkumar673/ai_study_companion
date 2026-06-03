import 'package:flutter/material.dart';
import '../../../../../core/services/ai_service.dart';

// ============================================================
//  AI Quiz Generator Screen (MCQs)
//
//  Features:
//    • Topic + question count selector
//    • Pulsing loading card during generation
//    • MCQ UI with A/B/C/D answer tiles
//    • Instant colour feedback (green ✓ / red ✗)
//    • Explanation panel after each answer
//    • Final score screen with grade + retry
//
//  🤗 HF Integration: AiService.generateQuiz()
//     Recommended models:
//       • valhalla/t5-base-qg-hl  (question generation from text)
//       • mistralai/Mistral-7B-Instruct-v0.3  (JSON MCQ via prompting)
//     Note: For best results, provide context text (e.g. the note body)
//     rather than just a topic string — models generate much richer MCQs.
// ============================================================

class AiQuizGeneratorScreen extends StatefulWidget {
  const AiQuizGeneratorScreen({super.key});

  @override
  State<AiQuizGeneratorScreen> createState() => _AiQuizGeneratorScreenState();
}

enum _Phase { setup, loading, quiz, results }

class _AiQuizGeneratorScreenState extends State<AiQuizGeneratorScreen> {
  final _topicController = TextEditingController();
  List<QuizQuestion> _questions = [];
  _Phase _phase = _Phase.setup;
  int _questionCount = 5;
  int _current = 0;
  final _answers = <int, int>{}; // questionIndex → chosen option index
  bool _answerRevealed = false;

  final _quickTopics = [
    'Biology',
    'Physics',
    'History',
    'Mathematics',
    'Chemistry',
    'Computer Science',
  ];

  Future<void> _generate() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic!')),
      );
      return;
    }

    setState(() {
      _phase = _Phase.loading;
      _questions = [];
      _current = 0;
      _answers.clear();
      _answerRevealed = false;
    });

    try {
      final qs = await AiService.instance.generateQuiz(topic, _questionCount);
      if (mounted) setState(() {
        _questions = qs;
        _phase = _Phase.quiz;
      });
    } catch (e) {
      if (mounted) setState(() => _phase = _Phase.setup);
    }
  }

  void _answer(int optionIndex) {
    if (_answerRevealed) return;
    setState(() {
      _answers[_current] = optionIndex;
      _answerRevealed = true;
    });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _answerRevealed = _answers.containsKey(_current);
      });
    } else {
      setState(() => _phase = _Phase.results);
    }
  }

  void _retry() {
    setState(() {
      _phase = _Phase.setup;
      _answers.clear();
      _current = 0;
      _answerRevealed = false;
      _questions = [];
    });
  }

  int get _score => _answers.entries
      .where((e) => e.value == _questions[e.key].correctIndex)
      .length;

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
            _GradientIcon(cs: cs),
            const SizedBox(width: 10),
            const Text('AI Quiz Generator'),
          ],
        ),
        actions: [
          if (_phase == _Phase.quiz)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  '${_current + 1}/${_questions.length}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: switch (_phase) {
          _Phase.setup    => _SetupView(
              key: const ValueKey('setup'),
              controller: _topicController,
              count: _questionCount,
              quickTopics: _quickTopics,
              cs: cs,
              theme: theme,
              onCountChanged: (v) => setState(() => _questionCount = v),
              onGenerate: _generate,
            ),
          _Phase.loading  => _LoadingView(key: const ValueKey('loading'), cs: cs),
          _Phase.quiz     => _QuizView(
              key: const ValueKey('quiz'),
              question: _questions[_current],
              questionIndex: _current,
              total: _questions.length,
              selected: _answers[_current],
              revealed: _answerRevealed,
              cs: cs,
              theme: theme,
              onAnswer: _answer,
              onNext: _next,
              isLast: _current == _questions.length - 1,
            ),
          _Phase.results  => _ResultsView(
              key: const ValueKey('results'),
              score: _score,
              total: _questions.length,
              questions: _questions,
              answers: _answers,
              cs: cs,
              theme: theme,
              onRetry: _retry,
            ),
        },
      ),
    );
  }
}

// ── Setup ───────────────────────────────────────────────────

class _SetupView extends StatelessWidget {
  const _SetupView({
    super.key,
    required this.controller,
    required this.count,
    required this.quickTopics,
    required this.cs,
    required this.theme,
    required this.onCountChanged,
    required this.onGenerate,
  });

  final TextEditingController controller;
  final int count;
  final List<String> quickTopics;
  final ColorScheme cs;
  final ThemeData theme;
  final ValueChanged<int> onCountChanged;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.quiz_outlined, size: 36, color: cs.primary),
                const SizedBox(height: 10),
                Text('AI Quiz Generator',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                  'Enter any topic and instantly get a custom multiple-choice quiz. '
                  'Great for exam prep and self-testing!',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onPrimaryContainer.withOpacity(0.7), height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text('Topic', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'e.g. Cell Biology, French Revolution…',
              prefixIcon: const Icon(Icons.quiz),
              filled: true,
              fillColor: cs.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: quickTopics.map((t) => ActionChip(
              label: Text(t, style: const TextStyle(fontSize: 12)),
              onPressed: () => controller.text = t,
              backgroundColor: cs.surfaceContainerHigh,
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
            )).toList(),
          ),
          const SizedBox(height: 20),

          Text('Questions', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [3, 5, 8, 10].map((n) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text('$n'),
                selected: count == n,
                onSelected: (_) => onCountChanged(n),
                selectedColor: cs.primaryContainer,
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: onGenerate,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Generate Quiz'),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
          ),
        ],
      ),
    );
  }
}

// ── Loading ─────────────────────────────────────────────────

class _LoadingView extends StatefulWidget {
  const _LoadingView({super.key, required this.cs});
  final ColorScheme cs;

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  int _step = 0;

  static const _steps = [
    '🔍 Analyzing your topic…',
    '❓ Crafting smart questions…',
    '🎯 Generating wrong answers…',
    '📝 Writing explanations…',
    '✅ Finalizing your quiz!',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
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
    final cs = widget.cs;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
              ),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [cs.primaryContainer, cs.primary.withOpacity(0.3)],
                  ),
                ),
                child: Icon(Icons.quiz, size: 48, color: cs.primary),
              ),
            ),
            const SizedBox(height: 32),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Text(
                _steps[_step],
                key: ValueKey(_step),
                style: TextStyle(fontSize: 16, color: cs.onSurface, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              backgroundColor: cs.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quiz ─────────────────────────────────────────────────────

class _QuizView extends StatelessWidget {
  const _QuizView({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.total,
    required this.selected,
    required this.revealed,
    required this.cs,
    required this.theme,
    required this.onAnswer,
    required this.onNext,
    required this.isLast,
  });

  final QuizQuestion question;
  final int questionIndex;
  final int total;
  final int? selected;
  final bool revealed;
  final ColorScheme cs;
  final ThemeData theme;
  final ValueChanged<int> onAnswer;
  final VoidCallback onNext;
  final bool isLast;

  static const _labels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (questionIndex + 1) / total,
              minHeight: 6,
              backgroundColor: cs.surfaceContainerHigh,
            ),
          ),
          const SizedBox(height: 20),

          // Question card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Q${questionIndex + 1}',
                          style: TextStyle(
                              color: cs.onPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                    const Spacer(),
                    Icon(Icons.quiz_outlined, size: 16, color: cs.primary),
                  ],
                ),
                const SizedBox(height: 12),
                Text(question.question,
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Options
          ...List.generate(question.options.length, (i) {
            final isCorrect = i == question.correctIndex;
            final isSelected = selected == i;

            Color? bgColor;
            Color? borderColor;
            IconData? trailingIcon;

            if (revealed) {
              if (isCorrect) {
                bgColor = Colors.green.shade100;
                borderColor = Colors.green;
                trailingIcon = Icons.check_circle;
              } else if (isSelected && !isCorrect) {
                bgColor = Colors.red.shade100;
                borderColor = Colors.red;
                trailingIcon = Icons.cancel;
              }
            } else if (isSelected) {
              bgColor = cs.primaryContainer;
              borderColor = cs.primary;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: revealed ? null : () => onAnswer(i),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: bgColor ?? cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: borderColor ?? cs.outline.withOpacity(0.3),
                      width: borderColor != null ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected || (revealed && isCorrect)
                              ? (borderColor ?? cs.primary)
                              : cs.surfaceContainerHigh,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          _labels[i],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isSelected || (revealed && isCorrect)
                                ? Colors.white
                                : cs.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(question.options[i],
                            style: theme.textTheme.bodyMedium?.copyWith(height: 1.3)),
                      ),
                      if (trailingIcon != null)
                        Icon(trailingIcon,
                            color: isCorrect ? Colors.green : Colors.red, size: 20),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Explanation
          if (revealed) ...[
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.green.shade700, size: 16),
                      const SizedBox(width: 6),
                      Text('Explanation',
                          style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(question.explanation,
                      style: TextStyle(color: Colors.green.shade800, fontSize: 13, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onNext,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text(isLast ? '🎉 See Results' : 'Next Question →'),
            ),
          ],

          if (!revealed)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Text('Tap an option to answer',
                    style: TextStyle(fontSize: 12, color: cs.outlineVariant)),
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Results ──────────────────────────────────────────────────

class _ResultsView extends StatelessWidget {
  const _ResultsView({
    super.key,
    required this.score,
    required this.total,
    required this.questions,
    required this.answers,
    required this.cs,
    required this.theme,
    required this.onRetry,
  });

  final int score;
  final int total;
  final List<QuizQuestion> questions;
  final Map<int, int> answers;
  final ColorScheme cs;
  final ThemeData theme;
  final VoidCallback onRetry;

  String get _grade {
    final pct = score / total;
    if (pct >= 0.9) return 'A+';
    if (pct >= 0.8) return 'A';
    if (pct >= 0.7) return 'B';
    if (pct >= 0.6) return 'C';
    return 'D';
  }

  String get _message {
    final pct = score / total;
    if (pct >= 0.9) return 'Outstanding! You nailed it! 🎉';
    if (pct >= 0.7) return 'Well done! Keep up the great work! 👍';
    if (pct >= 0.5) return 'Good effort! Review the missed questions.';
    return 'Keep practicing — you\'ll get there! 💪';
  }

  Color _gradeColor() {
    final pct = score / total;
    if (pct >= 0.8) return Colors.green;
    if (pct >= 0.6) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Score card
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text('Quiz Complete!',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 20),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _gradeColor().withOpacity(0.15),
                    border: Border.all(color: _gradeColor(), width: 3),
                  ),
                  child: Center(
                    child: Text(_grade,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: _gradeColor())),
                  ),
                ),
                const SizedBox(height: 16),
                Text('$score / $total correct',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(_message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onPrimaryContainer.withOpacity(0.8))),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: score / total,
                    minHeight: 10,
                    backgroundColor: cs.surfaceContainerHigh,
                    valueColor: AlwaysStoppedAnimation(_gradeColor()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Answer review
          Text('Review',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),

          ...List.generate(questions.length, (i) {
            final q = questions[i];
            final chosen = answers[i];
            final correct = chosen == q.correctIndex;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: correct
                    ? Colors.green.withOpacity(0.07)
                    : Colors.red.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: correct ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    correct ? Icons.check_circle : Icons.cancel,
                    color: correct ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q${i + 1}: ${q.question}',
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        if (!correct && chosen != null) ...[
                          const SizedBox(height: 3),
                          Text('Your answer: ${q.options[chosen]}',
                              style: const TextStyle(color: Colors.red, fontSize: 12)),
                        ],
                        const SizedBox(height: 3),
                        Text('Correct: ${q.options[q.correctIndex]}',
                            style: const TextStyle(color: Colors.green, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Another Quiz'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon({required this.cs});
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
      child: const Icon(Icons.quiz, size: 18, color: Colors.white),
    );
  }
}
