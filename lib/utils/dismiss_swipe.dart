import 'package:flutter/material.dart';

class DismissingWrapper extends StatefulWidget {
  const DismissingWrapper(
      {Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  State<DismissingWrapper> createState() => _DismissingWrapperState();
}

class _DismissingWrapperState extends State<DismissingWrapper> {
  Offset? triggerPoint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        triggerPoint = details.globalPosition;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (triggerPoint!.dx < details.globalPosition.dx - 50) {
          Navigator.pop(context);
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        triggerPoint = null;
      },
      child: widget.child,
    );
  }
}