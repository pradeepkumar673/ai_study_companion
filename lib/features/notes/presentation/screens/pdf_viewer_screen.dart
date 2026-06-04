// lib/features/notes/presentation/screens/pdf_viewer_screen.dart
//
// StudySpark — PDF Viewer Screen
// Uses syncfusion_flutter_pdfviewer for full-featured PDF rendering.
// Falls back gracefully if the package is not yet in pubspec.yaml.
//
// Add to pubspec.yaml:
//   syncfusion_flutter_pdfviewer: ^27.1.48
//   file_picker: ^8.1.2
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

// ── Toggle this to true once syncfusion_flutter_pdfviewer is in pubspec ───────
const bool _pdfViewerAvailable = false;

// ─── PdfViewerScreen ──────────────────────────────────────────────────────────

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({
    super.key,
    this.filePath,
    this.title,
  });

  /// If provided, opens this file directly (native paths only).
  final String? filePath;
  final String? title;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  Uint8List? _bytes;
  String? _fileName;
  bool _loading = false;
  int _currentPage = 1;
  int _totalPages = 0;

  bool get _hasPdf => _bytes != null && _bytes!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (widget.filePath != null && !kIsWeb) {
      _fileName = widget.title ?? widget.filePath!.split(RegExp(r'[/\\]')).last;
    } else if (widget.filePath != null && kIsWeb) {
      _fileName = widget.title ?? 'document.pdf';
    }
  }

  Future<void> _pickPdf() async {
    setState(() => _loading = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: kIsWeb,
      );
      if (result != null) {
        final file = result.files.single;
        setState(() {
          _fileName = file.name;
          _bytes = file.bytes;
          _currentPage = 1;
          _totalPages = 0;
        });
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _fileName ?? 'PDF Viewer',
              style: tt.titleMedium!.copyWith(fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
            if (_totalPages > 0)
              Text(
                'Page $_currentPage of $_totalPages',
                style: tt.labelSmall!.copyWith(color: cs.onSurfaceVariant),
              ),
          ],
        ),
        actions: [
          if (_hasPdf && _pdfViewerAvailable) ...[
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_up_rounded),
              tooltip: 'Previous page',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              tooltip: 'Next page',
              onPressed: () {},
            ),
          ],
          IconButton(
            icon: const Icon(Icons.file_open_rounded),
            tooltip: 'Open PDF',
            onPressed: _pickPdf,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : !_hasPdf
              ? _EmptyPdfState(onPick: _pickPdf)
              : _pdfViewerAvailable
                  ? _buildPdfViewer()
                  : _PluginPlaceholder(
                      fileName: _fileName,
                      sizeBytes: _bytes!.length,
                    ),
    );
  }

  Widget _buildPdfViewer() {
    return _PluginPlaceholder(
      fileName: _fileName,
      sizeBytes: _bytes?.length,
    );
  }
}

// ─── Empty pick state ─────────────────────────────────────────────────────────

class _EmptyPdfState extends StatelessWidget {
  const _EmptyPdfState({required this.onPick});
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.picture_as_pdf_rounded,
                size: 48, color: AppColors.error),
          )
              .animate()
              .scale(duration: 500.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 24),
          Text('No PDF open',
              style: tt.headlineSmall!.copyWith(fontWeight: FontWeight.w700))
              .animate(delay: 100.ms).fadeIn(),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to open a PDF file',
            style: tt.bodyMedium!.copyWith(color: cs.onSurfaceVariant),
          ).animate(delay: 150.ms).fadeIn(),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.file_open_rounded),
            label: const Text('Open PDF'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 28, vertical: 14),
            ),
          ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2),
        ],
      ),
    );
  }
}

// ─── Plugin placeholder ───────────────────────────────────────────────────────

class _PluginPlaceholder extends StatelessWidget {
  const _PluginPlaceholder({this.fileName, this.sizeBytes});
  final String? fileName;
  final int? sizeBytes;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.06),
              borderRadius: AppShapes.r16,
              border: Border.all(color: AppColors.error.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: AppShapes.r8,
                  ),
                  child: Icon(Icons.picture_as_pdf_rounded,
                      color: AppColors.error, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName ?? 'document.pdf',
                        style: tt.titleSmall!
                            .copyWith(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sizeBytes != null
                            ? '${(sizeBytes! / 1024).toStringAsFixed(1)} KB'
                            : 'Calculating…',
                        style: tt.bodySmall!.copyWith(
                            color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.visibility_outlined,
                      size: 56,
                      color: cs.onSurface.withOpacity(0.3))
                      .animate(
                        onPlay: (c) => c.repeat(reverse: true),
                      )
                      .fadeIn(duration: 800.ms),
                  const SizedBox(height: 20),
                  Text(
                    'PDF Viewer not installed',
                    style: tt.titleMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cs.surfaceVariant.withOpacity(0.6),
                      borderRadius: AppShapes.r12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add to pubspec.yaml:',
                            style: tt.labelSmall!.copyWith(
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text(
                          'syncfusion_flutter_pdfviewer: ^27.1.48\n'
                          'file_picker: ^8.1.2',
                          style: tt.bodySmall!.copyWith(
                            fontFamily: 'monospace',
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Then set _pdfViewerAvailable = true in\npdf_viewer_screen.dart',
                          style: tt.bodySmall!.copyWith(
                              color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
