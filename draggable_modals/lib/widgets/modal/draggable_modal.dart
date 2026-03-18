import 'package:flutter/material.dart';

import 'modal_content.dart';

class DraggableModal extends StatefulWidget {
  const DraggableModal({
    super.key,
    required this.data,
    required this.viewport,
    required this.onTap,
    required this.onClose,
    required this.onDrag,
    required this.onResize,
  });

  final ModalData data;
  final Size viewport;
  final VoidCallback onTap;
  final VoidCallback onClose;
  final ValueChanged<Offset> onDrag;
  final ValueChanged<Size> onResize;

  @override
  State<DraggableModal> createState() => _DraggableModalState();
}

class _DraggableModalState extends State<DraggableModal> {
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
