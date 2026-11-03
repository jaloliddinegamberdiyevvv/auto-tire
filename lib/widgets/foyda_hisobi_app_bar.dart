import 'package:flutter/material.dart';

class FoydaHisobiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoydaHisobiAppBar({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < 600 ? 12 : 24,
        ),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: MediaQuery.sizeOf(context).width < 600 ? 48 : 0,
          leading: MediaQuery.sizeOf(context).width < 600 && onMenuTap != null
              ? IconButton(
                  tooltip: 'Menyuni ochish',
                  onPressed: onMenuTap,
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                )
              : null,
          titleSpacing: 4,
          title: Text(
            'Foyda hisobi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
