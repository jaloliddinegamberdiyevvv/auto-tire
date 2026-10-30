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
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 145,
      ),
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> stat = stats[index];

        // Rasmni stats ichidan olamiz.
        final Image isImage = Image.asset(
          stat['image'] as String,
          fit: BoxFit.contain,
          color: Colors.white,
          colorBlendMode: BlendMode.srcIn,
        );

        return MouseRegion(
          onEnter: onHover == null ? null : (_) => onHover!(index),
          onExit: onHover == null ? null : (_) => onHover!(null),
          child: Container(
            padding: EdgeInsets.all(20),
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
                        style: TextStyle(
                          color: Color(0xFFA5A8AF),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF121212),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                      ),
                      child: isImage,
                    ),
                  ],
                ),
                Text(
                  stat['value'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stat['subtitle'] as String,
                  style: TextStyle(color: Color(0xFFA5A8AF), fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
