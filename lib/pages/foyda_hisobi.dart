import 'package:auto_tire/store/magazin_store.dart';
import 'package:auto_tire/widgets/foyda_hisobi_app_bar.dart';
import 'package:auto_tire/widgets/stat_cards_grid.dart';
import 'package:auto_tire/widgets/table_empty.dart';
import 'package:flutter/material.dart';

class FoydaHisobi extends StatelessWidget {
  FoydaHisobi({super.key});

  @override
  Widget build(BuildContext context) {
    final MagazinStore store = MagazinScope.of(context);
    final List<String> cats = ['yengil', 'yuk', 'disk', 'akkum'];

    final Map<String, _TopItem> productMap = <String, _TopItem>{};
    for (final SaleRecord s in store.sales) {
      final _TopItem item =
          productMap[s.productName] ?? _TopItem(qty: 0, profit: 0);
      item.qty += s.qty;
      item.profit += s.profit;
      productMap[s.productName] = item;
    }
    final List<MapEntry<String, _TopItem>> ranked = productMap.entries.toList();
    ranked.sort((MapEntry<String, _TopItem> a, MapEntry<String, _TopItem> b) {
      return b.value.profit.compareTo(a.value.profit);
    });
    final List<MapEntry<String, _TopItem>> top = ranked.take(8).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: FoydaHisobiAppBar(),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          StatCardsGrid(
            crossAxisCount: 4,
            stats: [
              {
                'title': 'Jami foyda',
                'value': fmtMillion(store.totalProfit),
                'subtitle': 'so\'m',
                'image': 'assets/qarz_qoldigi_image.png',
              },
              {
                'title': 'Jami aylanma',
                'value': fmtMillion(store.totalRevenue, digits: 1),
                'subtitle': 'so\'m',
                'image': 'assets/qarz_qoldigi_image.png',
              },
              {
                'title': 'Jami sotuvlar',
                'value': '${store.sales.length}',
                'subtitle': 'ta operatsiya',
                'image': 'assets/qarz_qoldigi_image.png',
              },
              {
                'title': 'Kutilgan qarzlar',
                'value': fmtMillion(store.pendingDebtSum),
                'subtitle': 'so\'m',
                'image': 'assets/qarz_qoldigi_image.png',
              },
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 325,
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoydaHisobiStatsBoxHeader(
                        title: 'Kategoriya bo\'yicha foyda',
                        icon: Icons.warning_amber_rounded,
                        iconColor: Colors.grey,
                      ),
                      KategoriyaFoydaBoxTableHeader(),
                      Expanded(
                        child: Column(
                          children: List.generate(cats.length, (int index) {
                            final String cat = cats[index];
                            final List<SaleRecord> catSales = store.sales
                                .where((SaleRecord s) => s.cat == cat)
                                .toList();
                            double profit = 0;
                            for (final SaleRecord s in catSales) {
                              profit += s.profit;
                            }
                            final double avg = catSales.isEmpty
                                ? 0
                                : profit / catSales.length;
                            return KategoriyaFoydaBoxRow(
                              kategoriya: categoryLabel(cat),
                              sotuvSoni: '${catSales.length} ta',
                              jamiFoyda: fmtSom(profit),
                              ortachaFoyda: fmtSom(avg.round()),
                              isLast: index == cats.length - 1,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 325,
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoydaHisobiStatsBoxHeader(
                        title: 'Eng ko\'p foyda keltirgan',
                        icon: Icons.warning_amber_rounded,
                        iconColor: Colors.grey,
                      ),
                      EngKopFoydaBoxTableHeader(),
                      Expanded(
                        child: top.isEmpty
                            ? TableEmpty(
                                icon: Icons.trending_up,
                                title: 'Hali sotuv yo\'q',
                                message:
                                    'Sotuvlar chiqqach shu yerda ko\'rinadi',
                              )
                            : ListView.builder(
                                itemCount: top.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final MapEntry<String, _TopItem> entry =
                                      top[index];
                                  return _TopProfitRow(
                                    rank: index + 1,
                                    name: entry.key,
                                    qty: entry.value.qty,
                                    profit: entry.value.profit,
                                    isLast: index == top.length - 1,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopItem {
  int qty;
  double profit;
  _TopItem({required this.qty, required this.profit});
}

class _TopProfitRow extends StatelessWidget {
  final int rank;
  final String name;
  final int qty;
  final double profit;
  final bool isLast;

  _TopProfitRow({
    required this.rank,
    required this.name,
    required this.qty,
    required this.profit,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              '#$rank  $name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 13.5),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$qty dona',
              style: TextStyle(color: Colors.white, fontSize: 13.5),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              fmtSom(profit),
              style: TextStyle(
                color: Color(0xFF00C853),
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoydaHisobiStatsBoxHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  FoydaHisobiStatsBoxHeader({
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

class KategoriyaFoydaBoxTableHeader extends StatelessWidget {
  KategoriyaFoydaBoxTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 38,
      color: Color(0xFF1D1D1D),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(flex: 3, child: _h('KATEGORIYA')),
          Expanded(flex: 2, child: _h('SOTUV SONI')),
          Expanded(flex: 2, child: _h('JAMI FOYDA')),
          Expanded(flex: 2, child: _h('O\'RTACHA FOYDA')),
        ],
      ),
    );
  }

  Widget _h(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFF8E8E8E),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class KategoriyaFoydaBoxRow extends StatelessWidget {
  final String kategoriya;
  final String sotuvSoni;
  final String jamiFoyda;
  final String ortachaFoyda;
  final bool isLast;

  KategoriyaFoydaBoxRow({
    super.key,
    required this.kategoriya,
    required this.sotuvSoni,
    required this.jamiFoyda,
    required this.ortachaFoyda,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 57,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF121212),
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              kategoriya,
              style: TextStyle(color: Colors.white, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              sotuvSoni,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              jamiFoyda,
              style: TextStyle(
                color: Color(0xFF00C853),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ortachaFoyda,
              style: TextStyle(color: Colors.white, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class EngKopFoydaBoxTableHeader extends StatelessWidget {
  EngKopFoydaBoxTableHeader({super.key});

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
              'MAHSULOT',
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
              'SONI',
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
        ],
      ),
    );
  }
}
