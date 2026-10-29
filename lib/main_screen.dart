import 'package:auto_tire/pages/akkumulyator.dart';
import 'package:auto_tire/pages/bosh_sahifa.dart';
import 'package:auto_tire/pages/diskalar.dart';
import 'package:auto_tire/pages/foyda_hisobi.dart';
import 'package:auto_tire/pages/qarzlar.dart';
import 'package:auto_tire/pages/sotuvlar.dart';
import 'package:auto_tire/pages/yengil_balon.dart';
import 'package:auto_tire/pages/yuk_balon.dart';
import 'package:auto_tire/store/magazin_store.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AutoTireMainScreen extends StatefulWidget {
  AutoTireMainScreen({super.key});

  @override
  State<AutoTireMainScreen> createState() => _AutoTireMainScreenState();
}

class _AutoTireMainScreenState extends State<AutoTireMainScreen> {
  // Hozir tanlangan sahifa indeksi.
  int _selectedIndex = 0;

  // Ilovadagi barcha sahifalar.
  final List<Widget> _pages = [
    BoshSahifa(),
    YengilBalon(),
    YukBalon(),
    Diskalar(),
    Akkumulyator(),
    Sotuvlar(),
    Qarzlar(),
    FoydaHisobi(),
  ];

  // Menyu orqali sahifani almashtirish.
  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0B0B),

      // Asosiy ekran va chap sidebar.
      body: Row(
        children: [
          // Doimiy chap menyu.
          SizedBox(
            width: 260,
            child: AutoTireLeftBar(
              selectedIndex: _selectedIndex,
              onTap: _changePage,
            ),
          ),

          // Sidebar va kontent orasidagi chiziq.
          Container(width: 2, color: Color(0xFF2A2A2A)),

          // Tanlangan sahifa.
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}

class AutoTireLeftBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  AutoTireLeftBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<AutoTireLeftBar> createState() => _AutoTireLeftBarState();
}

class _AutoTireLeftBarState extends State<AutoTireLeftBar> {
  // Sichqoncha ustida turgan menyu indeksi.
  int? _hoveredIndex;

  // Sidebar ranglari.
  final Color backgroundColor = Color(0xFF121212);
  final Color activeTileColor = Color(0xFF1F1F1F);
  final Color hoverTileColor = Color(0xFF1D1D1D);
  final Color textPrimaryColor = Color(0xFFFFFFFF);
  final Color textSecondaryColor = Color(0xFF8E8E8E);

  // Menyu ma'lumotlari.
  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Bosh sahifa', 'image': '', 'group': 'ASOSIY'},
    {
      'title': 'Yengil balon',
      'image': 'assets/yengil_balon.png',
      'group': 'MAHSULOTLAR',
    },
    {
      'title': 'Yuk balon',
      'image': 'assets/yuk_balon.png',
      'group': 'MAHSULOTLAR',
    },
    {'title': 'Disklar', 'image': 'assets/disklar.png', 'group': 'MAHSULOTLAR'},
    {
      'title': 'Akkumulyator',
      'image': 'assets/akkumlyator.png',
      'group': 'MAHSULOTLAR',
    },
    {'title': 'Sotuvlar', 'image': 'assets/sotuvlar.png', 'group': 'MOLIYA'},
    {'title': 'Qarzlar', 'image': 'assets/qarzlar.png', 'group': 'MOLIYA'},
    {
      'title': 'Foyda hisobi',
      'image': 'assets/foyda_hisobi.png',
      'group': 'MOLIYA',
    },
  ];

  // Bitta menyu elementini yaratish.
  Widget _buildMenuItem(int index) {
    final Map<String, dynamic> item = _menuItems[index];

    final bool isSelected = widget.selectedIndex == index;
    final bool isHovered = _hoveredIndex == index;

    final String title = item['title'] as String;
    final String imagePath = item['image'] as String;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: MouseRegion(
        // Sichqoncha menyu ustiga kelganda.
        onEnter: (_) {
          setState(() {
            _hoveredIndex = index;
          });
        },

        // Sichqoncha menyudan chiqqanda.
        onExit: (_) {
          setState(() {
            if (_hoveredIndex == index) {
              _hoveredIndex = null;
            }
          });
        },

        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected
                ? activeTileColor
                : isHovered
                ? hoverTileColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),

            // Tanlangan sahifani almashtirish.
            onTap: () => widget.onTap(index),

            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  // Bosh sahifa ikonasi.
                  if (index == 0)
                    FaIcon(
                      FontAwesomeIcons.house,
                      size: 18,
                      color: isSelected ? textPrimaryColor : textSecondaryColor,
                    )
                  else
                    // Mahsulot va moliya ikonkalari.
                    Image.asset(
                      imagePath,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      color: isSelected ? textPrimaryColor : textSecondaryColor,
                      colorBlendMode: BlendMode.srcIn,
                    ),

                  SizedBox(width: 12),

                  // Menyu nomi.
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected
                            ? textPrimaryColor
                            : textSecondaryColor,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (index == 6) _DebtBadge(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Guruh sarlavhasini yaratish.
  Widget _buildGroupTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 12, top: 16, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          color: textSecondaryColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo va brend nomi.
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  'assets/auto_tire_logo.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Tire',
                        style: TextStyle(
                          color: textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tire & Auto Parts',
                        style: TextStyle(
                          color: textSecondaryColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8),

          // Menyu elementlari.
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildGroupTitle('ASOSIY'),
                _buildMenuItem(0),

                _buildGroupTitle('MAHSULOTLAR'),
                _buildMenuItem(1),
                _buildMenuItem(2),
                _buildMenuItem(3),
                _buildMenuItem(4),

                _buildGroupTitle('MOLIYA'),
                _buildMenuItem(5),
                _buildMenuItem(6),
                _buildMenuItem(7),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Qarzlar menyusidagi qizil badge (HTML dagi debt-badge).
class _DebtBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MagazinStore store = MagazinScope.of(context);
    final int pending = store.pendingDebtCount;
    if (pending <= 0) {
      return SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFFF97316),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$pending',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
