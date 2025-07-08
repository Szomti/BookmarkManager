import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  final bool expand;
  final Widget child;

  const ExpandedSection({super.key, required this.expand, required this.child});

  @override
  State<StatefulWidget> createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late Animation<double> animation = CurvedAnimation(
    parent: expandController,
    curve: Curves.fastOutSlowIn,
  );

  bool get _expand => widget.expand;

  Widget get _child => widget.child;

  @override
  void initState() {
    super.initState();
    _runExpandCheck();
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void _runExpandCheck() {
    if (_expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: _child,
    );
  }
}
