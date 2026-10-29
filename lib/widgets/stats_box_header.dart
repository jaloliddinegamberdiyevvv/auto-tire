import 'package:flutter/material.dart';

class StatsBoxHeader extends StatelessWidget {
  final int count;
  StatsBoxHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 14),
          child: Container(
            height: 24,
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  'Mahsulotlar ro\'yxati',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Container(
                  height: 24,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      '$count ta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(color: Color(0xFF464646), height: 1),
      ],
    );
  }
}
