import 'dart:math' as math;

import 'package:flutter/material.dart';

class ResponsiveTable extends StatelessWidget {
  const ResponsiveTable({
    super.key,
    required this.minWidth,
    required this.child,
  });

  final double minWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tableWidth = math.max(minWidth, constraints.maxWidth);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            height: constraints.maxHeight,
            child: child,
          ),
        );
      },
    );
  }
}
