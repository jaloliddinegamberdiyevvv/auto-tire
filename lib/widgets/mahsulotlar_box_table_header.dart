import 'package:flutter/cupertino.dart';

class MahsulotlarBoxTableHeader extends StatelessWidget {
  final String title;
  MahsulotlarBoxTableHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 38,
      color: Color(0xFF1D1D1D),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'NOMI / $title',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'KELISH NARXI',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'SOTISH NARXI',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'MAX CHEGIRMA',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'OMBORDA',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'FOYDA',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'AMALLAR',
              style: TextStyle(
                color: Color(0xFF8E8E8E),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
