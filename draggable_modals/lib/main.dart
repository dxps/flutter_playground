import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'widgets/modal/draggable_modal.dart';
import 'widgets/modal/modal_content.dart';

const bgColor = Color(0xFFf4f2ee);

void main() {
  runApp(const MyApp());
}

enum _ModalMenuAction { notes, tasks, generic }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multiple Draggable Modals',
      theme: ThemeData(
        primaryColor: Colors.deepPurple[700],
        scaffoldBackgroundColor: bgColor,
      ),
      home: const MultiDraggableModalsPage(),
    );
  }
}

class MultiDraggableModalsPage extends StatefulWidget {
  const MultiDraggableModalsPage({super.key});

  @override
  State<MultiDraggableModalsPage> createState() => _MultiDraggableModalsPageState();
}

class _MultiDraggableModalsPageState extends State<MultiDraggableModalsPage> {
  final List<ModalData> _modals = <ModalData>[];
  int _nextId = 1;

  static const String _notesType = 'notes';
  static const String _tasksType = 'tasks';

  @override
  void initState() {
    super.initState();
    _openNotes();
    _openTasks();
  }

  bool _isTypeOpen(String type) {
    return _modals.any((m) => m.type == type);
  }

  void _openNotes() {
    if (_isTypeOpen(_notesType)) return;

    _addModal(
      type: _notesType,
      title: 'Notes',
      offset: const Offset(24, 80),
      size: const Size(340, 180),
      child: const _NotesContent(),
    );
  }

  void _openTasks() {
    if (_isTypeOpen(_tasksType)) return;

    _addModal(
      type: _tasksType,
      title: 'Tasks',
      offset: const Offset(80, 160),
      size: const Size(250, 190),
      child: const _TasksContent(),
    );
  }

  void _openGenericModal() {
    final int n = _nextId;
    final double left = 24.0 + ((n * 37) % 140);
    final double top = 80.0 + ((n * 53) % 220);

    _addModal(
      title: 'Modal $n',
      offset: Offset(left, top),
      size: const Size(300, 220),
      child: _GeneratedContent(index: n),
    );
  }

  void _addModal({String? type, required String title, required Offset offset, required Size size, required Widget child}) {
    setState(() {
      _modals.add(ModalData(id: _nextId++, type: type, title: title, offset: offset, size: size, child: child));
    });
  }

  void _bringToFront(int id) {
    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;
      final ModalData item = _modals.removeAt(index);
      _modals.add(item);
    });
  }

  void _closeModal(int id) {
    setState(() {
      _modals.removeWhere((m) => m.id == id);
    });
  }

  void _updatePosition(int id, Offset nextOffset, Size viewport) {
    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final ModalData modal = _modals[index];
      final double maxLeft = math.max(0, viewport.width - modal.size.width);
      final double maxTop = math.max(0, viewport.height - modal.size.height);

      _modals[index] = modal.copyWith(offset: Offset(nextOffset.dx.clamp(0.0, maxLeft), nextOffset.dy.clamp(0.0, maxTop)));
    });
  }

  void _updateSize(int id, Size nextSize, Size viewport) {
    const double minWidth = 240;
    const double minHeight = 160;

    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final ModalData modal = _modals[index];

      final double width = nextSize.width.clamp(minWidth, math.max(minWidth, viewport.width - modal.offset.dx));
      final double height = nextSize.height.clamp(minHeight, math.max(minHeight, viewport.height - modal.offset.dy));

      _modals[index] = modal.copyWith(size: Size(width, height));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Draggable Modals', style: TextStyle(fontSize: 16)),
        titleSpacing: 0,
        backgroundColor: bgColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size viewport = Size(constraints.maxWidth, constraints.maxHeight);

          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      'Use the "+" button to choose which modal to open.\n\n'
                      'Notes and Tasks can only be opened once at a time,\n'
                      'so their menu items are disabled while already visible.\n'
                      'Generic modals can be opened repeatedly.\n\n'
                      'Each modal can be moved by dragging its header,\n'
                      'resized from the bottom-right corner, brought to front\n'
                      'by tapping it, and closed individually.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),

              for (final modal in _modals)
                DraggableModal(
                  key: ValueKey(modal.id),
                  data: modal,
                  viewport: viewport,
                  onTap: () => _bringToFront(modal.id),
                  onClose: () => _closeModal(modal.id),
                  onDrag: (offset) => _updatePosition(modal.id, offset, viewport),
                  onResize: (size) => _updateSize(modal.id, size, viewport),
                ),
            ],
          );
        },
      ),
      floatingActionButton: PopupMenuButton<_ModalMenuAction>(
        tooltip: 'Open modal',
        color: Colors.white,
        menuPadding: const EdgeInsets.symmetric(vertical: 6),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        offset: const Offset(0, -50),
        onSelected: (action) {
          switch (action) {
            case _ModalMenuAction.notes:
              _openNotes();
              break;
            case _ModalMenuAction.tasks:
              _openTasks();
              break;
            case _ModalMenuAction.generic:
              _openGenericModal();
              break;
          }
        },
        itemBuilder: (context) {
          final bool notesOpen = _isTypeOpen(_notesType);
          final bool tasksOpen = _isTypeOpen(_tasksType);

          return [
            PopupMenuItem<_ModalMenuAction>(
              value: _ModalMenuAction.notes,
              enabled: !notesOpen,
              height: 26,
              child: const Text('Open Notes'),
            ),
            PopupMenuItem<_ModalMenuAction>(
              value: _ModalMenuAction.tasks,
              enabled: !tasksOpen,
              height: 26,
              child: const Text('Open Tasks'),
            ),
            PopupMenuDivider(height: 2, color: Colors.grey[300]),
            const PopupMenuItem<_ModalMenuAction>(value: _ModalMenuAction.generic, height: 26, child: Text('Open Generic Modal')),
          ];
        },
        child: const FloatingActionButton.small(onPressed: null, child: Icon(Icons.add_rounded)),
      ),
    );
  }
}

class _NotesContent extends StatelessWidget {
  const _NotesContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text('Meeting notes'),
        SizedBox(height: 12),
        Text('• Move modal system into a dedicated controller'),
        Text('• Add snapping positions'),
        Text('• Persist layout to local storage'),
        Text('• Add maximize/minimize actions'),
      ],
    );
  }
}

class _TasksContent extends StatelessWidget {
  const _TasksContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          value: true,
          onChanged: (_) {},
          title: Text('Header drag', style: TextStyle(fontSize: 16)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          value: true,
          onChanged: null,
          title: Text('Resize handle', style: TextStyle(fontSize: 16)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          value: true,
          onChanged: null,
          title: Text('Bring to front', style: TextStyle(fontSize: 16)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _GeneratedContent extends StatelessWidget {
  const _GeneratedContent({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 12,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text('Item ${index.toString()}-${i + 1}'),
          subtitle: const Text('Drag me, resize me, open more of me.'),
        );
      },
    );
  }
}
