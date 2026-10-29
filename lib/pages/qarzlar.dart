import 'package:auto_tire/store/magazin_store.dart';
import 'package:auto_tire/widgets/magazin_dialogs.dart';
import 'package:auto_tire/widgets/moliya_app_bar.dart';
import 'package:auto_tire/widgets/stat_cards_grid.dart';
import 'package:auto_tire/widgets/table_empty.dart';
import 'package:flutter/material.dart';

class Qarzlar extends StatefulWidget {
  Qarzlar({super.key});

  @override
  State<Qarzlar> createState() => _QarzlarState();
}

class _QarzlarState extends State<Qarzlar> {
  int selectedStatusIndex = 0;

  @override
  Widget build(BuildContext context) {
    final MagazinStore store = MagazinScope.of(context);
    final List<String> filters = ['all', 'pending', 'partial', 'paid'];
    final String filter = filters[selectedStatusIndex];
    final List<DebtRecord> debts = store.debts.where((DebtRecord d) {
      if (filter == 'all') return true;
      return d.status == filter;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MoliyaAppBar(
        title: 'Qarzlar',
        onAdd: () {
          showDebtDialog(context);
        },
        addButtonText: 'Qarz qo\'shish',
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            StatCardsGrid(
              crossAxisCount: 3,
              stats: [
                {
                  'title': 'Jami qarz',
                  'value': fmtN(store.pendingDebtSum),
                  'subtitle': 'so\'m',
                 'image': 'assets/qarz_qoldigi_image.png'
                },
                {
                  'title': 'Qarzkor mijozlar',
                  'value': '${store.debtClientCount}',
                  'subtitle': 'kishi',
                  'image': 'assets/qarz_qoldigi_image.png'
                },
                {
                  'title': 'To\'langan qarzlar',
                  'value': fmtN(store.paidDebtSum),
                  'subtitle': 'so\'m',
                  'image': 'assets/qarz_qoldigi_image.png'
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QarzlarStatsBoxHeader(
                      selectedIndex: selectedStatusIndex,
                      onStatusChanged: (int index) {
                        setState(() {
                          selectedStatusIndex = index;
                        });
                      },
                    ),
                    QarzlarBoxTableHeader(),
                    Expanded(
                      child: debts.isEmpty
                          ? TableEmpty(
                              icon: Icons.assignment_outlined,
                              title: 'Qarz topilmadi',
                              message: 'Hali qarz yo\'q',
                            )
                          : ListView.builder(
                              itemCount: debts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DebtRecord debt = debts[index];
                                return _DebtRow(
                                  debt: debt,
                                  isLast: index == debts.length - 1,
                                  onPay: () {
                                    showPayDebtDialog(context, debt);
                                  },
                                  onDelete: () async {
                                    final bool ok = await showConfirmDialog(
                                      context,
                                      'Qarzni o\'chirishni tasdiqlaysizmi?',
                                    );
                                    if (!ok) return;
                                    await store.deleteDebt(debt.id);
                                    if (!context.mounted) return;
                                    showMagazinSnack(
                                      context,
                                      'Qarz o\'chirildi',
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

class _DebtRow extends StatelessWidget {
  final DebtRecord debt;
  final bool isLast;
  final VoidCallback onPay;
  final VoidCallback onDelete;

  _DebtRow({
    required this.debt,
    required this.isLast,
    required this.onPay,
    required this.onDelete,
  });

  Color get _statusColor {
    if (debt.status == 'paid') return Color(0xFF00C853);
    if (debt.status == 'partial') return Color(0xFFF97316);
    return Color(0xFFEF5350);
  }

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
            flex: 4,
            child: Text(
              debt.clientName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              debt.clientPhone.isEmpty ? '—' : debt.clientPhone,
              style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              debt.product.isEmpty ? '—' : debt.product,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              fmtSom(debt.amount),
              style: TextStyle(
                color: Color(0xFFEF5350),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              fmtSom(debt.paid),
              style: TextStyle(
                color: Color(0xFF00C853),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              fmtSom(debt.remaining),
              style: TextStyle(
                color: Color(0xFFF97316),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              debt.date,
              style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 12),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              debtStatusLabel(debt.status),
              style: TextStyle(
                color: _statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                if (debt.status != 'paid')
                  IconButton(
                    tooltip: 'To\'lash',
                    onPressed: onPay,
                    icon: Icon(
                      Icons.payments_outlined,
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

class PaymentStatusFilter extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onStatusChanged;

  PaymentStatusFilter({
    super.key,
    required this.selectedIndex,
    required this.onStatusChanged,
  });

  final List<String> statuses = [
    'Barchasi',
    'To\'lanmagan',
    'Qisman to\'langan',
    'To\'langan',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2A2A2A), width: 1),
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(statuses.length, (int index) {
          final bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onStatusChanged(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF1F1F1F) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                statuses[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Color(0xFFA5A8AF),
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class QarzlarStatsBoxHeader extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onStatusChanged;

  QarzlarStatsBoxHeader({
    super.key,
    required this.selectedIndex,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 14),
          child: Row(
            children: [
              Text(
                'Qarzlar ro\'yxati',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              PaymentStatusFilter(
                selectedIndex: selectedIndex,
                onStatusChanged: onStatusChanged,
              ),
            ],
          ),
        ),
        Divider(color: Color(0xFF464646), height: 1),
      ],
    );
  }
}

class QarzlarBoxTableHeader extends StatelessWidget {
  QarzlarBoxTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 38,
      color: Color(0xFF1D1D1D),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _h('MIJOZ ISMI', 4),
          _h('TELEFON', 3),
          _h('MAHSULOT', 3),
          _h('QARZ MIQDORI', 3),
          _h('TO\'LANGAN', 3),
          _h('QOLDIQ', 3),
          _h('SANA', 3),
          _h('HOLATI', 2),
          _h('AMALLAR', 3),
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
