import 'package:auto_tire/store/magazin_store.dart';
import 'package:auto_tire/widgets/magazin_dialogs.dart';
import 'package:auto_tire/widgets/mahsulotlar_app_bar.dart';
import 'package:auto_tire/widgets/mahsulotlar_box_table_header.dart';
import 'package:auto_tire/widgets/stat_cards_grid.dart';
import 'package:auto_tire/widgets/stats_box_header.dart';
import 'package:auto_tire/widgets/table_empty.dart';
import 'package:flutter/material.dart';

// To‘rt mahsulot bo‘limi uchun umumiy sahifa (yengil/yuk/disk/akkum).
class MahsulotSahifa extends StatefulWidget {
  final String category;
  final String title;
  final String sizeColumnTitle;

  MahsulotSahifa({
    super.key,
    required this.category,
    required this.title,
    required this.sizeColumnTitle,
  });

  @override
  State<MahsulotSahifa> createState() => _MahsulotSahifaState();
}

class _MahsulotSahifaState extends State<MahsulotSahifa> {
  // TextEditingController — qidiruv maydoni uchun.
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MagazinStore store = MagazinScope.of(context);
    final List<Product> products = store.byCat(widget.category);
    final List<Product> visible = products.where((Product p) {
      if (_query.isEmpty) return true;
      final String haystack = '${p.name} ${p.size} ${p.note}'.toLowerCase();
      return haystack.contains(_query);
    }).toList();

    int totalStock = 0;
    double totalValue = 0;
    double profitSum = 0;
    for (final Product p in products) {
      totalStock += p.stock;
      totalValue += p.cost * p.stock;
      profitSum += p.profit;
    }
    final double avgProfit = products.isEmpty ? 0 : profitSum / products.length;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MahsulotlarAppBar(
        title: widget.title,
        searchController: _searchController,
        onSearchChanged: (String value) {
          setState(() {
            _query = value.toLowerCase();
          });
        },
        onAdd: () {
          showProductDialog(context, cat: widget.category);
        },
        onSale: () {
          showSaleDialog(context, lockedCat: widget.category);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            StatCardsGrid(
              crossAxisCount: 4,
              stats: [
                {
                  'title': 'Turlar soni',
                  'value': '${products.length}',
                  'subtitle': 'Tur mahsulot',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
                {
                  'title': 'Omboringiz',
                  'value': '$totalStock',
                  'subtitle': 'Jami dona',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
                {
                  'title': 'Ombor qiymati',
                  'value': fmtMillion(totalValue, digits: 1),
                  'subtitle': 'So‘m (kelish)',
                  'image': 'assets/qarz_qoldigi_image.png',
                },
                {
                  'title': 'O‘rtacha foyda',
                  'value': fmtN(avgProfit.round()),
                  'subtitle': 'So‘m / dona',
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
                    StatsBoxHeader(count: products.length),
                    MahsulotlarBoxTableHeader(title: widget.sizeColumnTitle),
                    Expanded(
                      child: visible.isEmpty
                          ? TableEmpty(
                              icon: Icons.inventory_2_outlined,
                              title: 'Mahsulot yo\'q',
                              message: 'Birinchi mahsulotni qo\'shing',
                            )
                          : ListView.builder(
                              itemCount: visible.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _ProductRow(
                                  product: visible[index],
                                  isLast: index == visible.length - 1,
                                  onEdit: () {
                                    showProductDialog(
                                      context,
                                      cat: widget.category,
                                      product: visible[index],
                                    );
                                  },
                                  onSell: () {
                                    showSaleDialog(
                                      context,
                                      lockedCat: widget.category,
                                      lockedProductId: visible[index].id,
                                    );
                                  },
                                  onDelete: () async {
                                    final bool ok = await showConfirmDialog(
                                      context,
                                      'Mahsulotni o\'chirishni tasdiqlaysizmi?',
                                    );
                                    if (!ok) return;
                                    await store.deleteProduct(
                                      widget.category,
                                      visible[index].id,
                                    );
                                    if (!context.mounted) return;
                                    showMagazinSnack(
                                      context,
                                      'Mahsulot o\'chirildi',
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

class _ProductRow extends StatelessWidget {
  final Product product;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback onSell;
  final VoidCallback onDelete;

  _ProductRow({
    required this.product,
    required this.isLast,
    required this.onEdit,
    required this.onSell,
    required this.onDelete,
  });

  Color get _stockColor {
    if (product.stock <= 2) return Color(0xFFEF5350);
    if (product.stock <= 5) return Color(0xFFF97316);
    return Color(0xFF00C853);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  product.size.isEmpty ? '—' : product.size,
                  style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              fmtSom(product.cost),
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
              fmtSom(product.price),
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
              '-${fmtSom(product.maxDiscount)}',
              style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13.5),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '${product.stock} dona',
              style: TextStyle(
                color: _stockColor,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fmtSom(product.profit),
                  style: TextStyle(
                    color: Color(0xFF00C853),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'min: ${fmtN(product.minProfit)}',
                  style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 11),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Sotish',
                  onPressed: onSell,
                  icon: Icon(
                    Icons.point_of_sale_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                IconButton(
                  tooltip: 'Tahrirlash',
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                IconButton(
                  tooltip: 'O\'chirish',
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF5350),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
