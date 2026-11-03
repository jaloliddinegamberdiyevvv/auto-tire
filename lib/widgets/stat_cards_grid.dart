import 'package:flutter/material.dart';

// Stat kartalar paneli — bosh sahifa, ombor, sotuv, qarz, foyda uchun.
class StatCardsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> stats;
  final int crossAxisCount;
  final ValueChanged<int?>? onHover;

  StatCardsGrid({
    super.key,
    required this.stats,
    required this.crossAxisCount,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int columns = ((width + 16) / 176)
            .floor()
            .clamp(1, crossAxisCount);
        final bool compact = width < 500;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: compact ? 10 : 16,
            mainAxisSpacing: compact ? 10 : 16,
            mainAxisExtent: compact ? 132 : 145,
          ),
          itemBuilder: (BuildContext context, int index) {
            final Map<String, dynamic> stat = stats[index];
            final IconData icon = stat['icon'] as IconData;

            return MouseRegion(
              onEnter: onHover == null ? null : (_) => onHover!(index),
              onExit: onHover == null ? null : (_) => onHover!(null),
              child: Container(
                padding: EdgeInsets.all(compact ? 14 : 20),
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            stat['title'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFFA5A8AF),
                              fontSize: compact ? 12 : 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 34,
                          height: 34,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFF121212),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFF2A2A2A),
                              width: 1,
                            ),
                          ),
                          child: Icon(icon, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                    Text(
                      stat['value'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: compact ? 21 : 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stat['subtitle'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFFA5A8AF),
                        fontSize: compact ? 10 : 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
