import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoliyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String addButtonText;
  final VoidCallback onAdd;
  final VoidCallback? onMenuTap;

  MoliyaAppBar({
    super.key,
    required this.title,
    required this.addButtonText,
    required this.onAdd,
    this.onMenuTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 520;
        final bool showDrawerButton =
            MediaQuery.sizeOf(context).width < 600 && onMenuTap != null;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 24),
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: false,
              titleSpacing: compact ? 4 : 12,
              automaticallyImplyLeading: false,
              leadingWidth: showDrawerButton ? 48 : 0,
              leading: showDrawerButton
                  ? IconButton(
                      tooltip: 'Menyuni ochish',
                      onPressed: onMenuTap,
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                    )
                  : null,
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  onPressed: onAdd,
                  child: Container(
                    height: 38,
                    padding: EdgeInsets.symmetric(
                      horizontal: compact ? 10 : 13,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFF2A2A2A),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_rounded, color: Colors.white, size: 18),
                        if (!compact) ...[
                          SizedBox(width: 6),
                          Text(
                            addButtonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
