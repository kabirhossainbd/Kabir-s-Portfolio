import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Lays children out in rows of equal-width columns, where every card in a
/// row stretches to the tallest one. The column count is derived from the
/// available width so the grid adapts inside any parent.
///
/// Children must support intrinsic sizing (avoid [LayoutBuilder] inside them).
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int Function(double maxWidth) columnsForWidth;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    required this.columnsForWidth,
    this.spacing = 18,
    this.runSpacing = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = math.max(
          1,
          math.min(columnsForWidth(constraints.maxWidth), children.length),
        );

        // Rows are always wrapped in IntrinsicHeight, even with one column, so
        // children always receive a bounded height (Spacer-safe).
        final rows = <Widget>[];
        for (int start = 0; start < children.length; start += columns) {
          final cells = <Widget>[];
          for (int c = 0; c < columns; c++) {
            if (c > 0) cells.add(SizedBox(width: spacing));
            final index = start + c;
            cells.add(
              Expanded(
                child: index < children.length
                    ? children[index]
                    : const SizedBox.shrink(),
              ),
            );
          }
          if (rows.isNotEmpty) rows.add(SizedBox(height: runSpacing));
          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: cells,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}
