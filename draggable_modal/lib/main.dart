// main.dart
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable Dialog (Flutter Web)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draggable dialog example')),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            await showDraggableDialog(
              context: context,
              title: 'Draggable dialog',
              contentBuilder: (context, controller) {
                return ListView.separated(
                  controller: controller, // same controller as Scrollbar
                  padding: const EdgeInsets.all(12),
                  itemCount: 50,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) => ListTile(
                    title: Text('Item $i'),
                    subtitle: const Text(
                      'Scroll inside; drag using the header only.',
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Open dialog'),
        ),
      ),
    );
  }
}

Future<T?> showDraggableDialog<T>({
  required BuildContext context,
  required String title,
  required Widget Function(BuildContext, ScrollController) contentBuilder,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (ctx, a1, a2) {
      return _DraggableDialogHost(title: title, contentBuilder: contentBuilder);
    },
    transitionBuilder: (ctx, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _DraggableDialogHost extends StatefulWidget {
  const _DraggableDialogHost({
    required this.title,
    required this.contentBuilder,
  });

  final String title;
  final Widget Function(BuildContext, ScrollController) contentBuilder;

  @override
  State<_DraggableDialogHost> createState() => _DraggableDialogHostState();
}

class _DraggableDialogHostState extends State<_DraggableDialogHost> {
  final GlobalKey _dialogKey = GlobalKey();
  Offset? _offset;

  Offset _clamp(Offset proposed) {
    final media = MediaQuery.of(context);
    final screen = media.size;

    final box = _dialogKey.currentContext?.findRenderObject() as RenderBox?;
    final dialogSize = box?.size ?? const Size(420, 420);

    const padding = 8.0;
    final minX = padding;
    final minY = padding + media.padding.top;
    final maxX = math.max(minX, screen.width - dialogSize.width - padding);
    final maxY = math.max(
      minY,
      screen.height - dialogSize.height - padding - media.padding.bottom,
    );

    return Offset(proposed.dx.clamp(minX, maxX), proposed.dy.clamp(minY, maxY));
  }

  void _ensureInitialOffset() {
    if (_offset != null) return;

    final screen = MediaQuery.of(context).size;
    final initial = Offset((screen.width - 420) / 2, (screen.height - 420) / 3);
    _offset = _clamp(initial);
  }

  @override
  Widget build(BuildContext context) {
    _ensureInitialOffset();

    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Positioned(
              left: _offset!.dx,
              top: _offset!.dy,
              child: _DialogSurface(
                key: _dialogKey,
                title: widget.title,
                contentBuilder: widget.contentBuilder,
                onDragDelta: (delta) {
                  setState(() => _offset = _clamp(_offset! + delta));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogSurface extends StatefulWidget {
  const _DialogSurface({
    super.key,
    required this.title,
    required this.onDragDelta,
    required this.contentBuilder,
  });

  final String title;
  final ValueChanged<Offset> onDragDelta;
  final Widget Function(BuildContext, ScrollController) contentBuilder;

  @override
  State<_DialogSurface> createState() => _DialogSurfaceState();
}

class _DialogSurfaceState extends State<_DialogSurface> {
  late final ScrollController _scrollController = ScrollController();
  bool _showThumb = false;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_scrollController.hasClients) {
        setState(() => _showThumb = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final header = Material(
      color: theme.colorScheme.surfaceContainerHighest,
      child: MouseRegion(
        cursor: _dragging
            ? SystemMouseCursors.grabbing
            : SystemMouseCursors.grab,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (_) => setState(() => _dragging = true),
          onPanEnd: (_) => setState(() => _dragging = false),
          onPanCancel: () => setState(() => _dragging = false),
          onPanUpdate: (details) => widget.onDragDelta(details.delta),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.open_with, size: 18),
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Material(
      elevation: 16,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 320,
          maxWidth: 560,
          minHeight: 180,
          maxHeight: 600,
        ),
        child: Column(
          children: [
            header,
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: kIsWeb && _showThumb,
                notificationPredicate: (n) => n.depth == 0,
                child: widget.contentBuilder(context, _scrollController),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
