import 'dart:math' as math;

import 'package:flutter/material.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[500]),
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
  final List<_ModalData> _modals = <_ModalData>[];
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
      offset: const Offset(80, 180),
      size: const Size(250, 180),
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

  void _addModal({
    String? type,
    required String title,
    required Offset offset,
    required Size size,
    required Widget child,
  }) {
    setState(() {
      _modals.add(_ModalData(id: _nextId++, type: type, title: title, offset: offset, size: size, child: child));
    });
  }

  void _bringToFront(int id) {
    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;
      final _ModalData item = _modals.removeAt(index);
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

      final _ModalData modal = _modals[index];
      final double maxLeft = math.max(0, viewport.width - modal.size.width);
      final double maxTop = math.max(0, viewport.height - modal.size.height);

      _modals[index] = modal.copyWith(
        offset: Offset(nextOffset.dx.clamp(0.0, maxLeft), nextOffset.dy.clamp(0.0, maxTop)),
      );
    });
  }

  void _updateSize(int id, Size nextSize, Size viewport) {
    const double minWidth = 240;
    const double minHeight = 160;

    setState(() {
      final int index = _modals.indexWhere((m) => m.id == id);
      if (index == -1) return;

      final _ModalData modal = _modals[index];

      final double width = nextSize.width.clamp(minWidth, math.max(minWidth, viewport.width - modal.offset.dx));
      final double height = nextSize.height.clamp(minHeight, math.max(minHeight, viewport.height - modal.offset.dy));

      _modals[index] = modal.copyWith(size: Size(width, height));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Draggable Modals', style: TextStyle(fontSize: 18)),
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
      ),
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final Size viewport = Size(constraints.maxWidth, constraints.maxHeight);

          return Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
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
                  ),
                ),
              ),
              for (final modal in _modals)
                _DraggableModal(
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
              child: const Text('Open Notes'),
            ),
            PopupMenuItem<_ModalMenuAction>(
              value: _ModalMenuAction.tasks,
              enabled: !tasksOpen,
              child: const Text('Open Tasks'),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<_ModalMenuAction>(value: _ModalMenuAction.generic, child: Text('Open Generic Modal')),
          ];
        },
        child: const FloatingActionButton.small(onPressed: null, child: Icon(Icons.add_rounded)),
      ),
    );
  }
}

class _DraggableModal extends StatefulWidget {
  const _DraggableModal({
    super.key,
    required this.data,
    required this.viewport,
    required this.onTap,
    required this.onClose,
    required this.onDrag,
    required this.onResize,
  });

  final _ModalData data;
  final Size viewport;
  final VoidCallback onTap;
  final VoidCallback onClose;
  final ValueChanged<Offset> onDrag;
  final ValueChanged<Size> onResize;

  @override
  State<_DraggableModal> createState() => _DraggableModalState();
}

class _DraggableModalState extends State<_DraggableModal> {
  Offset? _dragStartPointerGlobal;
  Offset? _dragStartOffset;

  Offset? _resizeStartPointerGlobal;
  Size? _resizeStartSize;

  bool _isDragging = false;
  bool _isResizing = false;

  void _startDrag(DragStartDetails details) {
    _dragStartPointerGlobal = details.globalPosition;
    _dragStartOffset = widget.data.offset;
    setState(() => _isDragging = true);
    widget.onTap();
  }

  void _updateDrag(DragUpdateDetails details) {
    if (_dragStartPointerGlobal == null || _dragStartOffset == null) {
      return;
    }

    final Offset delta = details.globalPosition - _dragStartPointerGlobal!;
    widget.onDrag(_dragStartOffset! + delta);
  }

  void _endDrag() {
    _dragStartPointerGlobal = null;
    _dragStartOffset = null;
    if (_isDragging) {
      setState(() => _isDragging = false);
    }
  }

  void _startResize(DragStartDetails details) {
    _resizeStartPointerGlobal = details.globalPosition;
    _resizeStartSize = widget.data.size;
    setState(() => _isResizing = true);
    widget.onTap();
  }

  void _updateResize(DragUpdateDetails details) {
    if (_resizeStartPointerGlobal == null || _resizeStartSize == null) {
      return;
    }

    final Offset delta = details.globalPosition - _resizeStartPointerGlobal!;

    widget.onResize(Size(_resizeStartSize!.width + delta.dx, _resizeStartSize!.height + delta.dy));
  }

  void _endResize() {
    _resizeStartPointerGlobal = null;
    _resizeStartSize = null;
    if (_isResizing) {
      setState(() => _isResizing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      left: widget.data.offset.dx,
      top: widget.data.offset.dy,
      width: widget.data.size.width,
      height: widget.data.size.height,
      child: Material(
        color: Colors.transparent,
        child: MouseRegion(
          cursor: _isDragging ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: widget.onTap,
            onPanStart: _startDrag,
            onPanUpdate: _updateDrag,
            onPanEnd: (_) => _endDrag(),
            onPanCancel: _endDrag,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(blurRadius: 22, offset: Offset(0, 0), color: Colors.black54)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6, right: 4),
                            child: const Icon(Icons.drag_indicator, size: 16, color: Colors.grey),
                          ),
                          Expanded(
                            child: Text(
                              widget.data.title,
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              tooltip: 'Close',
                              onPressed: widget.onClose,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                              visualDensity: VisualDensity.compact,
                              style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(padding: const EdgeInsets.all(12), child: widget.data.child),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: MouseRegion(
                              cursor: _isResizing
                                  ? SystemMouseCursors.resizeUpLeftDownRight
                                  : SystemMouseCursors.resizeUpLeftDownRight,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: widget.onTap,
                                onPanStart: _startResize,
                                onPanUpdate: _updateResize,
                                onPanEnd: (_) => _endResize(),
                                onPanCancel: _endResize,
                                child: Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Transform.rotate(
                                    angle: -0.9,
                                    child: Icon(
                                      Icons.filter_list,
                                      size: 18,
                                      color: theme.colorScheme.onSurfaceVariant.withAlpha(40),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalData {
  const _ModalData({
    required this.id,
    this.type,
    required this.title,
    required this.offset,
    required this.size,
    required this.child,
  });

  final int id;
  final String? type;
  final String title;
  final Offset offset;
  final Size size;
  final Widget child;

  _ModalData copyWith({String? type, String? title, Offset? offset, Size? size, Widget? child}) {
    return _ModalData(
      id: id,
      type: type ?? this.type,
      title: title ?? this.title,
      offset: offset ?? this.offset,
      size: size ?? this.size,
      child: child ?? this.child,
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
