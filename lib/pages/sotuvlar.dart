import 'package:auto_tire/store/magazin_store.dart';
import 'package:auto_tire/widgets/magazin_dialogs.dart';
import 'package:auto_tire/widgets/moliya_app_bar.dart';
import 'package:auto_tire/widgets/stat_cards_grid.dart';
import 'package:auto_tire/widgets/table_empty.dart';
import 'package:flutter/material.dart';

class Sotuvlar extends StatelessWidget {
  Sotuvlar({super.key});

  @override
  Widget build(BuildContext context) {
    final MagazinStore store = MagazinScope.of(context);
    final List<SaleRecord> sales = store.sales;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MoliyaAppBar(
        title: 'Sotuvlar',
        onAdd: () {
          showSaleDialog(context);
        },
        addButtonText: 'Yangi sotuv',
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            StatCardsGrid(
              crossAxisCount: 4,
              stats: [
                {
                  'title': 'Jami sotuv',
                  'value': fmtMillion(store.totalRevenue),
                  'subtitle': 'so\'m',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
                {
                  'title': 'Jami foyda',
                  'value': fmtMillion(store.totalProfit),
                  'subtitle': 'so\'m',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
                {
                  'title': 'Operatsiyalar',
                  'value': '${sales.length}',
                  'subtitle': 'ta sotuv',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
                {
                  'title': 'Bugungi sotuv',
                  'value': '${store.todaySales.length}',
                  'subtitle': 'ta operatsiya',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF2A2A2A), width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SotuvlarStatsBoxHeader(count: sales.length),
                    SotuvlarBoxTableHeader(),
                    Expanded(
                      child: sales.isEmpty
                          ? TableEmpty(
                              icon: Icons.point_of_sale_outlined,
                              title: 'Hali sotuv yo\'q',
                              message: 'Hali sotuv amalga oshirilmagan',
                            )
                          : ListView.builder(
                              itemCount: sales.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SaleRecord sale = sales[index];
                                return _SaleRow(
                                  sale: sale,
                                  isLast: index == sales.length - 1,
                                  onDelete: () async {
                                    final bool ok = await showConfirmDialog(
                                      context,
                                      'Sotuvni o\'chirishni tasdiqlaysizmi?',
                                    );
                                    if (!ok) return;
                                    await store.deleteSale(sale.id);
                                    if (!context.mounted) return;
                                    showMagazinSnack(
                                      context,
                                      'Sotuv o\'chirildi',
                                    );
                                  },
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
      ),
    );
  }
}

class _SaleRow extends StatelessWidget {
  final SaleRecord sale;
  final bool isLast;
  final VoidCallback onDelete;

  _SaleRow({required this.sale, required this.isLast, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              sale.date,
              style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 12),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              sale.productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              categoryLabel(sale.cat),
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${sale.qty} dona',
              style: TextStyle(color: Colors.white, fontSize: 13.5),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              fmtSom(sale.unitPrice),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              fmtSom(sale.total),
              style: TextStyle(
                color: Color(0xFFF97316),
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '+${fmtSom(sale.profit)}',
              style: TextStyle(
                color: Color(0xFF00C853),
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              paymentLabel(sale.payment),
              style: TextStyle(
                color: sale.payment == 'qarz'
                    ? Color(0xFFEF5350)
                    : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                color: Color(0xFFEF5350),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SotuvlarStatsBoxHeader extends StatelessWidget {
  final int count;
  SotuvlarStatsBoxHeader({super.key, required this.count});

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
                  'Sotuvlar tarixi',
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

class SotuvlarBoxTableHeader extends StatelessWidget {
  SotuvlarBoxTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 38,
      color: Color(0xFF1D1D1D),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _h('SANA', 3),
          _h('MAHSULOT', 4),
          _h('KATEGORIYA', 3),
          _h('SONI', 2),
          _h('SOTISH NARXI', 3),
          _h('JAMI', 3),
          _h('FOYDA', 3),
          _h('TO\'LOV', 3),
          _h('AMALLAR', 2),
        ],
      ),
    );
  }

  Widget _h(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF8E8E8E),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
