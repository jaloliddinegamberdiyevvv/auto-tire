import 'dart:async';

import 'package:auto_tire/store/magazin_store.dart';
import 'package:auto_tire/user_profile.dart';
import 'package:auto_tire/widgets/bosh_sahifa_app_bar.dart';
import 'package:auto_tire/widgets/stat_cards_grid.dart';
import 'package:auto_tire/widgets/table_empty.dart';
import 'package:flutter/material.dart';

class BoshSahifa extends StatefulWidget {
  final UserProfile profile;
  final VoidCallback? onMenuTap;
  final ValueChanged<int?>? onMenuHover;

  BoshSahifa({
    super.key,
    required this.profile,
    this.onMenuTap,
    this.onMenuHover,
  });

  @override
  State<BoshSahifa> createState() => _BoshSahifaState();
}

class _BoshSahifaState extends State<BoshSahifa> {
  late DateTime currentDateTime;
  Timer? dateTimeTimer;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    currentDateTime = DateTime.now();
    dateTimeTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!mounted) return;
      setState(() {
        currentDateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    dateTimeTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  String get formattedDate {
    final String day = currentDateTime.day.toString().padLeft(2, '0');
    final String month = currentDateTime.month.toString().padLeft(2, '0');
    final String year = currentDateTime.year.toString();
    return '$day.$month.$year';
  }

  void _updateSearch(String value) {
    setState(() {
      _query = value.toLowerCase();
    });
  }

  int _menuIndexForProduct(MagazinStore store, Product product) {
    const Map<String, int> categoryMenuIndexes = {
      'yengil': 1,
      'yuk': 2,
      'disk': 3,
      'akkum': 4,
    };
    for (final MapEntry<String, int> entry in categoryMenuIndexes.entries) {
      if (store.byCat(entry.key).any((Product item) => item.id == product.id)) {
        return entry.value;
      }
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final MagazinStore store = MagazinScope.of(context);
    final List<SaleRecord> today = store.todaySales;
    double todayProfit = 0;
    for (final SaleRecord s in today) {
      todayProfit += s.profit;
    }

    final List<SaleRecord> recent = store.sales
        .where((SaleRecord s) {
          if (_query.isEmpty) return true;
          return s.productName.toLowerCase().contains(_query);
        })
        .take(6)
        .toList();

    final List<Product> lowStock = store.allProducts
        .where((Product p) => p.stock <= 3)
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BoshSahifaAppBar(
        formattedDate: formattedDate,
        onMenuTap: widget.onMenuTap,
        firstName: widget.profile.firstName,
        lastName: widget.profile.lastName,
        login: widget.profile.email,
        password: widget.profile.password,
        onProfileChanged: (UserProfile profile) => profile.save(),
        searchController: _searchController,
        onSearchChanged: _updateSearch,
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width < 700 ? 12 : 24),
        children: [
          if (MediaQuery.sizeOf(context).width < 700) ...[
            Container(
              height: 42,
              decoration: BoxDecoration(
                color: Color(0xFF121212),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFF2A2A2A)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _updateSearch,
                style: TextStyle(color: Colors.white, fontSize: 13),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Sotuvni qidirish...',
                  hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.white70,
                    size: 19,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
          StatCardsGrid(
            crossAxisCount: 5,
            onHover: (int? statIndex) {
              const List<int> menuIndexes = [7, 1, 5, 6, 5];
              widget.onMenuHover?.call(
                statIndex == null ? null : menuIndexes[statIndex],
              );
            },
            stats: [
              {
                'title': 'Jami foyda',
                'value': fmtMillion(store.totalProfit),
                'subtitle': 'Barcha vaqt uchun',
                'icon': Icons.trending_up_rounded,
              },
              {
                'title': 'Ombor qiymati',
                'value': fmtMillion(store.warehouseValue, digits: 1),
                'subtitle': '${store.warehouseStock} dona mahsulot',
                'icon': Icons.inventory_2_outlined,
              },
              {
                'title': 'Jami sotuvlar',
                'value': '${store.sales.length}',
                'subtitle': 'ta operatsiya',
                'icon': Icons.point_of_sale_outlined,
              },
              {
                'title': 'Qarz qoldig‘i',
                'value': fmtMillion(store.pendingDebtSum),
                'subtitle': '${store.pendingDebtCount} ta mijoz',
                'icon': Icons.account_balance_wallet_outlined,
              },
              {
                'title': 'Bugungi sotuvlar',
                'value': '${today.length}',
                'subtitle': '${fmtN(todayProfit)} so\'m foyda',
                'icon': Icons.today_outlined,
              },
            ],
          ),
          SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final Widget recentSalesPanel = Container(
                height: 325,
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxHeader(
                      icon: Icons.access_time,
                      iconColor: Colors.grey,
                      title: "So‘nggi sotuvlar",
                    ),
                    Expanded(
                      child: recent.isEmpty
                          ? TableEmpty(
                              icon: Icons.receipt_long_outlined,
                              title: 'Hali sotuv yo\'q',
                              message: 'Birinchi sotuvni qo\'shing',
                            )
                          : ListView.builder(
                              itemCount: recent.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SaleRecord sale = recent[index];
                                return _ActivityRow(
                                  title: sale.productName,
                                  subtitle:
                                      '${sale.date} · ${sale.qty} dona · +${fmtSom(sale.profit)}',
                                  color: Color(0xFF00C853),
                                  onHoverEnter: () =>
                                      widget.onMenuHover?.call(5),
                                  onHoverExit: () =>
                                      widget.onMenuHover?.call(null),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
              final Widget lowStockPanel = Container(
                height: 325,
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxHeader(
                      icon: Icons.warning_amber_rounded,
                      iconColor: Colors.grey,
                      title: "Kam qolgan mahsulotlar",
                    ),
                    Expanded(
                      child: lowStock.isEmpty
                          ? TableEmpty(
                              icon: Icons.check_circle_outline,
                              title: 'Hammasi yetarli',
                              message: 'Barcha mahsulotlar yetarli',
                            )
                          : ListView.builder(
                              itemCount: lowStock.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Product p = lowStock[index];
                                return _ActivityRow(
                                  title: '${p.name} ${p.size}',
                                  subtitle: p.stock == 0
                                      ? 'Tugagan'
                                      : '${p.stock} dona qoldi',
                                  color: p.stock == 0
                                      ? Color(0xFFEF5350)
                                      : Color(0xFFF97316),
                                  onHoverEnter: () => widget.onMenuHover
                                      ?.call(_menuIndexForProduct(store, p)),
                                  onHoverExit: () =>
                                      widget.onMenuHover?.call(null),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );

              if (constraints.maxWidth < 760) {
                return Column(
                  children: [
                    recentSalesPanel,
                    SizedBox(height: 16),
                    lowStockPanel,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: recentSalesPanel),
                  SizedBox(width: 16),
                  Expanded(child: lowStockPanel),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;

  _ActivityRow({
    required this.title,
    required this.subtitle,
    required this.color,
    this.onHoverEnter,
    this.onHoverExit,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onHoverEnter == null ? null : (_) => onHoverEnter!(),
      onExit: onHoverExit == null ? null : (_) => onHoverExit!(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  BoxHeader({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          child: Container(
            height: 24,
            color: Colors.transparent,
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 18),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(color: Color(0xFF2A2A2A), thickness: 1, height: 1),
      ],
    );
  }
}
