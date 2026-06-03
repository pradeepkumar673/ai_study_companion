// lib/features/notes/presentation/widgets/voice_to_notes_sheet.dart
//
// StudySpark — Voice-to-Notes using speech_to_text.
// Listens to microphone input and transcribes into the note body.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../core/theme/app_theme.dart';

// ─── VoiceToNotesSheet ────────────────────────────────────────────────────────

class VoiceToNotesSheet extends StatefulWidget {
  const VoiceToNotesSheet({super.key, this.initialText = ''});

  /// Pre-filled text (append mode).
  final String initialText;

  @override
  State<VoiceToNotesSheet> createState() => _VoiceToNotesSheetState();
}

class _VoiceToNotesSheetState extends State<VoiceToNotesSheet>
    with TickerProviderStateMixin {
  final SpeechToText _stt = SpeechToText();
  bool _available = false;
  bool _listening = false;
  bool _initializing = true;
  String _lastWords = '';
  String _accumulated = '';
  double _confidence = 0;

  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _accumulated = widget.initialText;
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _available = await _stt.initialize(
      onError: (e) => setState(() => _listening = false),
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _listening = false);
          _pulseCtrl.stop();
        }
      },
    );
    setState(() => _initializing = false);
  }

  void _startListening() async {
    if (!_available) return;
    await _stt.listen(
      onResult: _onResult,
      listenFor: const Duration(minutes: 5),
      pauseFor: const Duration(seconds: 3),
      localeId: 'en_US',
    );
    setState(() => _listening = true);
    _pulseCtrl.repeat(reverse: true);
  }

  void _stopListening() async {
    await _stt.stop();
    setState(() {
      if (_lastWords.isNotEmpty) {
        _accumulated = _accumulated.isEmpty
            ? _lastWords
            : '$_accumulated $_lastWords';
        _lastWords = '';
      }
      _listening = false;
    });
    _pulseCtrl.stop();
  }

  void _onResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _confidence = result.hasConfidenceRating ? result.confidence : 0;
      if (result.finalResult) {
        _accumulated = _accumulated.isEmpty
            ? result.recognizedWords
            : '$_accumulated ${result.recognizedWords}';
        _lastWords = '';
      }
    });
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _stt.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final displayText = _accumulated +
        (_lastWords.isNotEmpty
            ? (_accumulated.isNotEmpty ? ' ' : '') + _lastWords
            : '');

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurface.withOpacity(0.2),
                borderRadius: AppShapes.r8,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                const Icon(Icons.mic_rounded, size: 22),
                const SizedBox(width: 10),
                Text('Voice to Notes',
                    style: tt.titleMedium!
                        .copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Transcript area
          Expanded(
            child: _initializing
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: AppColors.primary),
                        const SizedBox(height: 12),
                        Text('Initialising microphone…',
                            style: tt.bodySmall),
                      ],
                    ),
                  )
                : !_available
                    ? _UnavailableState()
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: displayText.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 32),
                                    Icon(Icons.mic_none_rounded,
                                        size: 56,
                                        color: cs.onSurface.withOpacity(0.3)),
                                    const SizedBox(height: 12),
                                    Text(
                                      _listening
                                          ? 'Listening…'
                                          : 'Tap the mic to start',
                                      style: tt.bodyMedium!.copyWith(
                                          color:
                                              cs.onSurface.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _accumulated,
                                    style: tt.bodyLarge!
                                        .copyWith(height: 1.7),
                                  ),
                                  if (_lastWords.isNotEmpty)
                                    Text(
                                      _lastWords,
                                      style: tt.bodyLarge!.copyWith(
                                        height: 1.7,
                                        color: AppColors.primary
                                            .withOpacity(0.6),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              ),
                      ),
          ),

          // Confidence badge
          if (_confidence > 0 && _listening)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.graphic_eq_rounded,
                      size: 14, color: AppColors.secondary),
                  const SizedBox(width: 4),
                  Text(
                    'Confidence: ${(_confidence * 100).toStringAsFixed(0)}%',
                    style: tt.labelSmall!
                        .copyWith(color: AppColors.secondary),
                  ),
                ],
              ),
            ),

          // Controls
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Row(
              children: [
                // Clear
                if (displayText.isNotEmpty)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          setState(() {
                            _accumulated = '';
                            _lastWords = '';
                          }),
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      label: const Text('Clear'),
                    ),
                  ),
                if (displayText.isNotEmpty) const SizedBox(width: 12),

                // Mic button
                _MicButton(
                  listening: _listening,
                  available: _available,
                  pulseCtrl: _pulseCtrl,
                  onStart: _startListening,
                  onStop: _stopListening,
                ),

                if (displayText.isNotEmpty) const SizedBox(width: 12),
                // Use
                if (displayText.isNotEmpty)
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () =>
                          Navigator.pop(context, _accumulated),
                      icon: const Icon(Icons.check_rounded, size: 18),
                      label: const Text('Use Text'),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

// ─── Mic button with pulse animation ─────────────────────────────────────────

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.listening,
    required this.available,
    required this.pulseCtrl,
    required this.onStart,
    required this.onStop,
  });

  final bool listening;
  final bool available;
  final AnimationController pulseCtrl;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseCtrl,
      builder: (_, child) {
        final scale = listening ? (1.0 + 0.1 * pulseCtrl.value) : 1.0;
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        onTap: available ? (listening ? onStop : onStart) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: listening ? Colors.red : AppColors.primary,
            boxShadow: listening
                ? AppShadows.glow(Colors.red)
                : AppShadows.md(AppColors.primary),
          ),
          child: Icon(
            listening ? Icons.stop_rounded : Icons.mic_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

// ─── Unavailable state ────────────────────────────────────────────────────────

class _UnavailableState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mic_off_rounded, size: 56, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Microphone unavailable',
              style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Please grant microphone permission in your device settings.',
              style: tt.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
