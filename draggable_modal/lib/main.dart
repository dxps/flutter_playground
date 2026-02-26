// main.dart
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
              child: const _DialogContent(),
            );
          },
          child: const Text('Open dialog'),
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: 30,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, i) => ListTile(
        title: Text('Item $i'),
        subtitle: const Text('Scroll inside; drag using the header only.'),
      ),
    );
  }
}

Future<T?> showDraggableDialog<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (ctx, a1, a2) {
      return _DraggableDialogHost(title: title, child: child);
    },
    transitionBuilder: (ctx, anim, _, dialog) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1.0).animate(curved),
          child: dialog,
        ),
      );
    },
  );
}

class _DraggableDialogHost extends StatefulWidget {
  const _DraggableDialogHost({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  State<_DraggableDialogHost> createState() => _DraggableDialogHostState();
}

class _DraggableDialogHostState extends State<_DraggableDialogHost> {
  final GlobalKey _dialogKey = GlobalKey();
  Offset? _offset; // computed after first layout

  // Clamp so the dialog stays onscreen.
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
    final media = MediaQuery.of(context);
    final screen = media.size;

    // Reasonable initial placement (near center).
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
                onDragDelta: (delta) {
                  setState(() {
                    _offset = _clamp(_offset! + delta);
                  });
                },
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogSurface extends StatelessWidget {
  const _DialogSurface({
    super.key,
    required this.title,
    required this.onDragDelta,
    required this.child,
  });

  final String title;
  final ValueChanged<Offset> onDragDelta;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final header = Material(
      color: theme.colorScheme.surfaceContainerHighest,
      child: InkWell(
        // Only the header is draggable, so scrolling content won’t fight drag.
        onTap: () {},
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) => onDragDelta(details.delta),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // On web/desktop, show a "move" cursor over the header.
                if (kIsWeb)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.open_with, size: 18),
                  ),
                Expanded(
                  child: Text(
                    title,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            Expanded(
              child: Scrollbar(
                thumbVisibility: kIsWeb, // nicer on web
                child: child,
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
