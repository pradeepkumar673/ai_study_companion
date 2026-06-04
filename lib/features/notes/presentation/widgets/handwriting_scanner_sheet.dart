// lib/features/notes/presentation/widgets/handwriting_scanner_sheet.dart
//
// StudySpark — Handwritten Note Scanner
// Uses google_mlkit_text_recognition to OCR images from camera / gallery.
// Gracefully falls back to a placeholder if the plugin is unavailable.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_theme.dart';

// ─── Try importing MLKit; if not available, use stub ─────────────────────────
// NOTE: Conditional import so the file compiles even if the package is absent.
// Add to pubspec.yaml:
//   google_mlkit_text_recognition: ^0.13.1
//   image_picker: ^1.1.2

// ─── HandwritingScannerSheet ──────────────────────────────────────────────────

class HandwritingScannerSheet extends StatefulWidget {
  const HandwritingScannerSheet({super.key});

  @override
  State<HandwritingScannerSheet> createState() =>
      _HandwritingScannerSheetState();
}

class _HandwritingScannerSheetState extends State<HandwritingScannerSheet> {
  Uint8List? _imageBytes;
  String _scannedText = '';
  bool _scanning = false;
  bool _done = false;

  final ImagePicker _picker = ImagePicker();

  // ── MLKit availability flag ───────────────────────────────────────────────
  // Set to true when google_mlkit_text_recognition is added to pubspec.yaml
  static const bool _mlkitAvailable = false; // <── toggle when plugin added

  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 90,
      maxWidth: 2048,
    );
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    setState(() {
      _imageBytes = bytes;
      _scannedText = '';
      _done = false;
    });

    if (_mlkitAvailable) {
      await _runOcr(bytes);
    } else {
      // Simulate a short delay to show the "scanning" state
      setState(() => _scanning = true);
      await Future.delayed(const Duration(milliseconds: 1500));
      setState(() {
        _scanning = false;
        _done = true;
        _scannedText =
            '⚠️ OCR not available.\n\nAdd google_mlkit_text_recognition '
            'to pubspec.yaml and set _mlkitAvailable = true in '
            'handwriting_scanner_sheet.dart to enable real recognition.';
      });
    }
  }

  Future<void> _runOcr(Uint8List bytes) async {
    setState(() => _scanning = true);
    try {
      // ── Uncomment when google_mlkit_text_recognition is in pubspec ─────
      // final recognizer = TextRecognizer(
      //   script: TextRecognitionScript.latin,
      // );
      // final inputImage = InputImage.fromFile(file);
      // final RecognizedText result = await recognizer.processImage(inputImage);
      // await recognizer.close();
      // setState(() {
      //   _scannedText = result.text;
      //   _scanning = false;
      //   _done = true;
      // });
    } catch (e) {
      setState(() {
        _scannedText = 'Error during recognition: $e';
        _scanning = false;
        _done = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.85,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(28)),
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
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.tertiary.withOpacity(0.1),
                    borderRadius: AppShapes.r8,
                  ),
                  child: Icon(Icons.document_scanner_outlined,
                      size: 20, color: AppColors.tertiary),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scan Handwriting',
                        style: tt.titleMedium!
                            .copyWith(fontWeight: FontWeight.w700)),
                    if (!_mlkitAvailable)
                      Text('Plugin not installed  ·  placeholder mode',
                          style: tt.labelSmall!.copyWith(
                              color: AppColors.tertiary)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 16),

          // Pick source buttons
          if (_imageBytes == null) ...[
            Expanded(child: _PickerPlaceholder(onPick: _pickImage)),
          ] else ...[
            // Image preview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: AppShapes.r12,
                child: Image.memory(
                  _imageBytes!,
                  height: size.height * 0.28,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Scan / re-pick row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _imageBytes = null;
                      _scannedText = '';
                      _done = false;
                    }),
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Change'),
                  ),
                  const SizedBox(width: 10),
                  if (!_done)
                    FilledButton.icon(
                      onPressed: _scanning
                          ? null
                          : () => _runOcr(_imageBytes!),
                      icon: _scanning
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white),
                            )
                          : const Icon(Icons.text_snippet_outlined,
                              size: 16),
                      label: Text(_scanning ? 'Scanning…' : 'Recognise'),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Scanned text
            Expanded(
              child: _scanning
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 12),
                          Text('Recognising text…', style: tt.bodySmall),
                        ],
                      ),
                    )
                  : _scannedText.isNotEmpty
                      ? _ScannedTextArea(
                          text: _scannedText,
                          mlkitAvailable: _mlkitAvailable,
                          onUse: () =>
                              Navigator.pop(context, _scannedText),
                        )
                      : _mlkitAvailable
                          ? Center(
                              child: Text(
                                  'Tap "Recognise" to extract text',
                                  style: tt.bodyMedium!.copyWith(
                                      color: cs.onSurfaceVariant)),
                            )
                          : const SizedBox.shrink(),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Picker placeholder ───────────────────────────────────────────────────────

class _PickerPlaceholder extends StatelessWidget {
  const _PickerPlaceholder({required this.onPick});
  final Future<void> Function(ImageSource) onPick;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.tertiary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.document_scanner_rounded,
              size: 44, color: AppColors.tertiary),
        )
            .animate()
            .scale(duration: 500.ms, curve: Curves.easeOutBack),
        const SizedBox(height: 20),
        Text('Scan handwritten notes',
            style:
                tt.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text('Take a photo or choose from gallery',
            style: tt.bodySmall!
                .copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SourceButton(
              icon: Icons.camera_alt_rounded,
              label: 'Camera',
              color: AppColors.tertiary,
              onTap: () => onPick(ImageSource.camera),
            ),
            const SizedBox(width: 16),
            _SourceButton(
              icon: Icons.photo_library_rounded,
              label: 'Gallery',
              color: AppColors.primary,
              onTap: () => onPick(ImageSource.gallery),
            ),
          ],
        ),
        if (!_HandwritingScannerSheetState._mlkitAvailable) ...[
          const SizedBox(height: 28),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.tertiary.withOpacity(0.08),
              borderRadius: AppShapes.r12,
              border: Border.all(
                  color: AppColors.tertiary.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 16, color: AppColors.tertiary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Add google_mlkit_text_recognition to pubspec.yaml '
                    'to enable real OCR.',
                    style: tt.bodySmall!
                        .copyWith(color: AppColors.tertiary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _SourceButton extends StatelessWidget {
  const _SourceButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppShapes.r16,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: AppShapes.r16,
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Scanned text area ────────────────────────────────────────────────────────

class _ScannedTextArea extends StatefulWidget {
  const _ScannedTextArea({
    required this.text,
    required this.mlkitAvailable,
    required this.onUse,
  });

  final String text;
  final bool mlkitAvailable;
  final VoidCallback onUse;

  @override
  State<_ScannedTextArea> createState() => _ScannedTextAreaState();
}

class _ScannedTextAreaState extends State<_ScannedTextArea> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                widget.mlkitAvailable
                    ? Icons.check_circle_outline_rounded
                    : Icons.warning_amber_rounded,
                size: 16,
                color: widget.mlkitAvailable
                    ? Colors.green
                    : AppColors.tertiary,
              ),
              const SizedBox(width: 6),
              Text(
                widget.mlkitAvailable
                    ? 'Text recognised — edit if needed'
                    : 'Placeholder result',
                style: tt.labelSmall!.copyWith(
                  color: widget.mlkitAvailable
                      ? Colors.green
                      : AppColors.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceVariant.withOpacity(0.5),
                borderRadius: AppShapes.r12,
              ),
              child: TextField(
                controller: _ctrl,
                maxLines: null,
                expands: true,
                style: tt.bodyMedium!.copyWith(height: 1.6),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Recognised text…',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () =>
                  Navigator.pop(context, _ctrl.text),
              icon: const Icon(Icons.check_rounded, size: 18),
              label: const Text('Use in Note'),
            ),
          ),
        ],
      ),
    );
  }
}
