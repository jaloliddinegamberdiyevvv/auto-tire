import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MahsulotlarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onAdd;
  final VoidCallback? onSale;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onMenuTap;

  MahsulotlarAppBar({
    super.key,
    required this.title,
    required this.onAdd,
    this.onSale,
    this.searchController,
    this.onSearchChanged,
    this.onMenuTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 560;
        final bool showDrawerButton =
            MediaQuery.sizeOf(context).width < 600 && onMenuTap != null;
        final double searchWidth = (constraints.maxWidth * 0.25)
            .clamp(90, 220)
            .toDouble();
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 24),
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: false,
              titleSpacing: compact ? 4 : 12,
              automaticallyImplyLeading: false,
              leadingWidth: showDrawerButton ? 44 : 0,
              leading: showDrawerButton
                  ? IconButton(
                      tooltip: 'Menyuni ochish',
                      onPressed: onMenuTap,
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                    )
                  : null,
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                SizedBox(
                  width: searchWidth,
                  height: 38,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Focus.of(context).hasFocus
                            ? Color(0xFF555555)
                            : Color(0xFF2A2A2A),
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearchChanged,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white, fontSize: 12.5),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Qidirish...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: compact ? 4 : 8),
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
                      border: Border.all(color: Color(0xFF2A2A2A), width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_rounded, color: Colors.white, size: 18),
                        if (!compact) ...[
                          SizedBox(width: 6),
                          Text(
                            'Mahsulot qo‘shish',
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
