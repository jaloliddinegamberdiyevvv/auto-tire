import 'package:flutter/material.dart';

// Jadval bo‘sh bo‘lganda ko‘rsatiladigan holat.
class TableEmpty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  TableEmpty({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Color(0xFF8E8E8E), size: 42),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
