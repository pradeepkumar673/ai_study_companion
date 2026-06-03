import 'package:flutter/material.dart';
import 'ai_assistant_screen.dart';
import '../../../summarizer/presentation/screens/ai_summarizer_screen.dart';
import '../../../flashcard_generator/presentation/screens/ai_flashcard_generator_screen.dart';
import '../../../quiz_generator/presentation/screens/ai_quiz_generator_screen.dart';

// ============================================================
//  AI Hub Screen
//
//  Central landing page for all AI features.
//  Shows animated feature cards, usage tips, and quick access.
//
//  Features:
//    • Animated entrance with staggered card reveals
//    • "Powered by AI" status indicator
//    • Recent activity placeholder
//    • Navigation to each AI feature
// ============================================================

class AiHubScreen extends StatefulWidget {
  const AiHubScreen({super.key});

  @override
  State<AiHubScreen> createState() => _AiHubScreenState();
}

class _AiHubScreenState extends State<AiHubScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<Animation<double>> _fadeAnims;

  static const _features = [
    _AiFeature(
      icon: Icons.psychology_outlined,
      title: 'Study Assistant',
      description: 'Ask any question, get concept explanations, exam strategies, and more.',
      tag: 'Chat',
      gradient: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
      model: 'Mistral-7B-Instruct',
    ),
    _AiFeature(
      icon: Icons.auto_awesome,
      title: 'Notes Summarizer',
      description: 'Paste your notes and get a compressed summary with key points and terms.',
      tag: 'NLP',
      gradient: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
      model: 'BART-large-CNN',
    ),
    _AiFeature(
      icon: Icons.style_outlined,
      title: 'Flashcard Generator',
      description: 'Auto-generate a spaced-repetition deck from any topic in seconds.',
      tag: 'Generative',
      gradient: [Color(0xFF10B981), Color(0xFF059669)],
      model: 'Mistral-7B-Instruct',
    ),
    _AiFeature(
      icon: Icons.quiz_outlined,
      title: 'Quiz Generator',
      description: 'Create custom MCQs with explanations for exam practice.',
      tag: 'MCQ',
      gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)],
      model: 'T5-QG + Mistral',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200 + _features.length * 150),
    )..forward();

    _fadeAnims = List.generate(_features.length, (i) {
      final start = i * 0.15;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: _ctrl,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _navigate(int index) {
    final screen = switch (index) {
      0 => const AiAssistantScreen(),
      1 => const AiSummarizerScreen(),
      2 => const AiFlashcardGeneratorScreen(),
      3 => const AiQuizGeneratorScreen(),
      _ => const AiAssistantScreen(),
    };
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar.large(
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('AI Features'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cs.primaryContainer,
                      cs.secondaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 48),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          'Powered by AI 🤗',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onPrimaryContainer.withOpacity(0.7),
                          ),
                        ),
                      ),
                      // [HF_API] Status indicator — replace with real API ping
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('AI Ready',
                                style: TextStyle(color: Colors.green, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // HF banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // [HF_API] This banner links to actual Hugging Face integration
                  color: cs.tertiaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text('🤗', style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hugging Face Integration Ready',
                              style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w700)),
                          Text(
                            // [HF_API] Replace with your actual HF token management info
                            'Connect your HF API token in Settings → AI to enable live models',
                            style: theme.textTheme.labelSmall?.copyWith(
                                color: cs.onTertiaryContainer.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Setup'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Feature cards
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => FadeTransition(
                  opacity: _fadeAnims[i],
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(_fadeAnims[i]),
                    child: _FeatureCard(
                      feature: _features[i],
                      onTap: () => _navigate(i),
                      theme: theme,
                      cs: cs,
                    ),
                  ),
                ),
                childCount: _features.length,
              ),
            ),
          ),

          // Tips section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: _TipsCard(cs: cs, theme: theme),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.feature,
    required this.onTap,
    required this.theme,
    required this.cs,
  });

  final _AiFeature feature;
  final VoidCallback onTap;
  final ThemeData theme;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: feature.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: feature.gradient[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(feature.icon, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(feature.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: feature.gradient[0].withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(feature.tag,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: feature.gradient[0],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(feature.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant, height: 1.4)),
                      const SizedBox(height: 6),
                      // [HF_API] Model badge shows which HF model powers this feature
                      Row(
                        children: [
                          Text('🤗 ',
                              style: const TextStyle(fontSize: 10)),
                          Text(feature.model,
                              style: TextStyle(fontSize: 10, color: cs.outlineVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 14, color: cs.outlineVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard({required this.cs, required this.theme});
  final ColorScheme cs;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates_outlined, color: cs.primary, size: 18),
              const SizedBox(width: 8),
              Text('Pro Tips',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          ...[
            '✏️  Write better notes first — AI summaries are only as good as the input.',
            '🔁  Use the Flashcard Generator after every lecture to reinforce memory.',
            '🎯  Quiz yourself the day before an exam for maximum retention.',
            '💬  Ask the Study Assistant to explain *why*, not just *what*.',
          ].map((tip) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(tip,
                style: theme.textTheme.bodySmall?.copyWith(height: 1.5)),
          )),
        ],
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────

class _AiFeature {
  final IconData icon;
  final String title;
  final String description;
  final String tag;
  final List<Color> gradient;
  final String model; // [HF_API] HF model name displayed on card

  const _AiFeature({
    required this.icon,
    required this.title,
    required this.description,
    required this.tag,
    required this.gradient,
    required this.model,
  });
}
