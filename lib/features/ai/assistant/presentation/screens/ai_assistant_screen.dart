import 'package:flutter/material.dart';
import '../../../../../core/services/ai_service.dart';
import '../../../../../core/utils/haptic_utils.dart';

// ============================================================
//  AI Study Assistant Screen
//
//  Features:
//    • Full chat UI with user + AI bubbles
//    • Typing indicator animation (three pulsing dots)
//    • Quick-starter suggestion chips
//    • Message timestamps
//
//  🤗 HF Integration: AiService.chat() — see ai_service.dart
//     Recommended model: mistralai/Mistral-7B-Instruct-v0.3
// ============================================================

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen>
    with TickerProviderStateMixin {
  final _messages = <AiMessage>[];
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;
  late AnimationController _typingAnim;

  static const _suggestions = [
    '🔬 Explain photosynthesis',
    '⚖️ Newton\'s laws of motion',
    '🧠 Best memory techniques',
    '⏱️ How Pomodoro works',
    '📝 Help me make flashcards',
    '🎯 Quiz me on a topic',
  ];

  @override
  void initState() {
    super.initState();
    _typingAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    // Greeting message on open
    Future.microtask(() {
      setState(() {
        _messages.add(AiMessage(
          id: 'welcome',
          text: "Hi! I'm your AI study companion 🎓\n\n"
              "I can explain concepts, answer questions, quiz you, or help you understand tricky topics. "
              "Try one of the suggestions below or just ask anything!",
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    });
  }

  @override
  void dispose() {
    _typingAnim.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isTyping) return;

    HapticUtils.light();
    _controller.clear();
    setState(() {
      _messages.add(AiMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: trimmed,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });
    _scrollToBottom();

    try {
      final reply = await AiService.instance.chat(trimmed, List.unmodifiable(_messages));
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(AiMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: reply,
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom(delay: 80);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(AiMessage(
            id: 'err_${DateTime.now().millisecondsSinceEpoch}',
            text: '⚠️ Sorry, I couldn\'t reach the AI right now. Please check your connection and try again.',
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom(delay: 80);
      }
    }
  }

  void _scrollToBottom({int delay = 0}) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cs.primary, cs.tertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.psychology, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Study Assistant',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                Text(
                  _isTyping ? 'typing…' : 'online',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _isTyping ? cs.primary : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear chat',
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add(AiMessage(
                  id: 'reset',
                  text: 'Chat cleared. Ask me anything! 😊',
                  isUser: false,
                  timestamp: DateTime.now(),
                ));
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(cs)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (ctx, i) {
                      if (_isTyping && i == _messages.length) {
                        return _TypingBubble(animation: _typingAnim, cs: cs);
                      }
                      return _MessageBubble(
                          message: _messages[i], cs: cs, textTheme: theme.textTheme);
                    },
                  ),
          ),

          // Suggestion chips (only when no user messages yet)
          if (_messages.length <= 1)
            _SuggestionChips(
              suggestions: _suggestions,
              onTap: _send,
              cs: cs,
            ),

          _InputBar(controller: _controller, onSend: _send, isTyping: _isTyping, cs: cs),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: cs.outlineVariant),
          const SizedBox(height: 12),
          Text('Ask me anything about your studies!',
              style: TextStyle(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}

// ── Message Bubble ─────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.cs,
    required this.textTheme,
  });

  final AiMessage message;
  final ColorScheme cs;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: cs.primaryContainer,
              child: Icon(Icons.psychology, size: 16, color: cs.primary),
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? cs.primary : cs.surfaceContainerHigh,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isUser ? 18 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: textTheme.bodyMedium?.copyWith(
                      color: isUser ? cs.onPrimary : cs.onSurface,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTime(message.timestamp),
                  style: textTheme.labelSmall?.copyWith(color: cs.outlineVariant),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 14,
              backgroundColor: cs.primaryContainer,
              child: Icon(Icons.person, size: 16, color: cs.primary),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

// ── Typing indicator ────────────────────────────────────────

class _TypingBubble extends StatelessWidget {
  const _TypingBubble({required this.animation, required this.cs});

  final AnimationController animation;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: cs.primaryContainer,
            child: Icon(Icons.psychology, size: 16, color: cs.primary),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (_, __) {
                    final delay = i * 0.3;
                    final val = (animation.value + delay).clamp(0.0, 1.0);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(0.4 + val * 0.6),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Suggestion chips ────────────────────────────────────────

class _SuggestionChips extends StatelessWidget {
  const _SuggestionChips({
    required this.suggestions,
    required this.onTap,
    required this.cs,
  });

  final List<String> suggestions;
  final ValueChanged<String> onTap;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (ctx, i) => ActionChip(
          label: Text(suggestions[i], style: const TextStyle(fontSize: 12)),
          onPressed: () => onTap(suggestions[i]),
          backgroundColor: cs.primaryContainer.withOpacity(0.5),
          side: BorderSide(color: cs.primary.withOpacity(0.3)),
        ),
      ),
    );
  }
}

// ── Input bar ───────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.isTyping,
    required this.cs,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSend;
  final bool isTyping;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border(top: BorderSide(color: cs.outlineVariant.withOpacity(0.4))),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: !isTyping,
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: onSend,
                decoration: InputDecoration(
                  hintText: isTyping ? 'AI is thinking…' : 'Ask anything…',
                  filled: true,
                  fillColor: cs.surfaceContainerHigh,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: FloatingActionButton.small(
                onPressed: isTyping ? null : () => onSend(controller.text),
                backgroundColor: isTyping ? cs.surfaceContainerHigh : cs.primary,
                child: isTyping
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.primary,
                        ),
                      )
                    : Icon(Icons.send_rounded, color: cs.onPrimary, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
