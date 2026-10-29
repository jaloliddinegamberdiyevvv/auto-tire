import 'package:auto_tire/store/magazin_store.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void showMagazinSnack(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Color(0xFFB91C1C) : Color(0xFF15803D),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Future<bool> showConfirmDialog(BuildContext context, String message) async {
  final bool? ok = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF121212),
        title: Text('Tasdiqlash', style: TextStyle(color: Colors.white)),
        content: Text(message, style: TextStyle(color: Color(0xFFA5A8AF))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Ha'),
          ),
        ],
      );
    },
  );
  return ok == true;
}

InputDecoration _fieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13),
    filled: true,
    fillColor: Color(0xFF0B0B0B),
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF2A2A2A), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF555555), width: 1.5),
    ),
  );
}

Widget _dialogTextField({
  required TextEditingController controller,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  ValueChanged<String>? onChanged,
  required TextStyle style,
  required InputDecoration decoration,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    onChanged: onChanged,
    style: style,
    decoration: decoration,
    cursorColor: Colors.white,
    cursorWidth: 1.5,
    cursorHeight: 15,
  );
}

class _UzbekPhoneFormatter extends TextInputFormatter {
  const _UzbekPhoneFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('998')) {
      digits = digits.substring(3);
    } else if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    if (digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    final List<String> groups = [];
    if (digits.isNotEmpty) {
      groups.add(digits.substring(0, digits.length < 2 ? digits.length : 2));
    }
    if (digits.length > 2) {
      groups.add(digits.substring(2, digits.length < 5 ? digits.length : 5));
    }
    if (digits.length > 5) {
      groups.add(digits.substring(5, digits.length < 7 ? digits.length : 7));
    }
    if (digits.length > 7) {
      groups.add(digits.substring(7));
    }
    final String formatted = groups.join(' ');

    final int oldOffset = newValue.selection.baseOffset
        .clamp(0, newValue.text.length)
        .toInt();
    int digitCount = RegExp(
      r'\d',
    ).allMatches(newValue.text.substring(0, oldOffset)).length;
    if (digitCount > digits.length) {
      digitCount = digits.length;
    }

    int caretOffset = digitCount;
    if (digitCount > 2 || (digitCount == 2 && digits.length > 2)) {
      caretOffset++;
    }
    if (digitCount > 5 || (digitCount == 5 && digits.length > 5)) {
      caretOffset++;
    }
    if (digitCount > 7 || (digitCount == 7 && digits.length > 7)) {
      caretOffset++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: caretOffset),
    );
  }
}

Widget _withWhiteCursor(BuildContext context, Widget child) {
  return Theme(
    data: Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
    ),
    child: child,
  );
}

Widget _darkSelect<T>({
  required T? selected,
  required List<DropdownMenuItem<T>> items,
  required ValueChanged<T?>? onChanged,
  String hint = 'Tanlang',
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Color(0xFF0B0B0B),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFF2A2A2A)),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: selected,
        hint: Text(
          hint,
          style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13.5),
        ),
        isExpanded: true,
        dropdownColor: Color(0xFF1D1D1D),
        style: TextStyle(color: Colors.white, fontSize: 13.5),
        items: items,
        onChanged: onChanged,
      ),
    ),
  );
}

Widget _label(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Color(0xFFA5A8AF),
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Future<void> showProductDialog(
  BuildContext context, {
  required String cat,
  Product? product,
}) async {
  final MagazinStore store = MagazinScope.of(context);
  final TextEditingController name = TextEditingController(
    text: product?.name ?? '',
  );
  final TextEditingController size = TextEditingController(
    text: product?.size ?? '',
  );
  final TextEditingController cost = TextEditingController(
    text: product == null ? '' : product.cost.round().toString(),
  );
  final TextEditingController price = TextEditingController(
    text: product == null ? '' : product.price.round().toString(),
  );
  final TextEditingController discount = TextEditingController(
    text: product == null ? '' : product.maxDiscount.round().toString(),
  );
  final TextEditingController stock = TextEditingController(
    text: product == null ? '' : product.stock.toString(),
  );
  final TextEditingController note = TextEditingController(
    text: product?.note ?? '',
  );

  await showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setLocal) {
              final double costVal = double.tryParse(cost.text) ?? 0;
              final double priceVal = double.tryParse(price.text) ?? 0;
              final double discVal = double.tryParse(discount.text) ?? 0;
              final bool showPreview = costVal > 0 && priceVal > 0;

              return _withWhiteCursor(
                context,
                AlertDialog(
                  backgroundColor: Color(0xFF121212),
                  title: Text(
                    product == null
                        ? 'Qo\'shish — ${categoryLabel(cat)}'
                        : 'Tahrirlash — ${categoryLabel(cat)}',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  content: SizedBox(
                    width: 520,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Nomi / Markasi'),
                                    _dialogTextField(
                                      controller: name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                      ),
                                      decoration: _fieldDecoration(
                                        'Mas: Michelin, 205/55R16',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Razmer / Model'),
                                    _dialogTextField(
                                      controller: size,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                      ),
                                      decoration: _fieldDecoration(
                                        'Mas: 205/55R16, 6AT55',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Kelish narxi (so\'m)'),
                                    _dialogTextField(
                                      controller: cost,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => setLocal(() {}),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                      ),
                                      decoration: _fieldDecoration('540000'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Sotish narxi (so\'m)'),
                                    _dialogTextField(
                                      controller: price,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => setLocal(() {}),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                      ),
                                      decoration: _fieldDecoration('600000'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Max chegirma (so\'m)'),
                                    _dialogTextField(
                                      controller: discount,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => setLocal(() {}),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                      ),
                                      decoration: _fieldDecoration('30000'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label('Ombordagi soni'),
                                    _dialogTextField(
                                      controller: stock,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.5,
                                      ),
                                      decoration: _fieldDecoration('10'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          _label('Izoh (ixtiyoriy)'),
                          _dialogTextField(
                            controller: note,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                            ),
                            decoration: _fieldDecoration(
                              'Qo\'shimcha ma\'lumot...',
                            ),
                          ),
                          if (showPreview) ...[
                            SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Color(0x14F97316),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0x40F97316)),
                              ),
                              child: Column(
                                children: [
                                  _previewRow(
                                    'Sotish narxi:',
                                    fmtSom(priceVal),
                                  ),
                                  _previewRow('Kelish narxi:', fmtSom(costVal)),
                                  _previewRow(
                                    'Asosiy foyda:',
                                    fmtSom(priceVal - costVal),
                                    color: Color(0xFF00C853),
                                  ),
                                  Divider(color: Color(0x40F97316)),
                                  _previewRow(
                                    'Chegirma bilan min foyda:',
                                    fmtSom(priceVal - discVal - costVal),
                                    color: Color(0xFFF97316),
                                    big: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text('Bekor qilish'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final String? error = await store.saveProduct(
                          cat: cat,
                          editId: product?.id,
                          name: name.text.trim(),
                          size: size.text.trim(),
                          cost: double.tryParse(cost.text) ?? 0,
                          price: double.tryParse(price.text) ?? 0,
                          maxDiscount: double.tryParse(discount.text) ?? 0,
                          stock: int.tryParse(stock.text) ?? 0,
                          note: note.text.trim(),
                        );
                        if (!dialogContext.mounted) return;
                        if (error != null) {
                          showMagazinSnack(dialogContext, error, isError: true);
                          return;
                        }
                        Navigator.pop(dialogContext);
                        showMagazinSnack(context, 'Mahsulot saqlandi!');
                      },
                      child: Text('Saqlash'),
                    ),
                  ],
                ),
              );
            },
      );
    },
  );

  name.dispose();
  size.dispose();
  cost.dispose();
  price.dispose();
  discount.dispose();
  stock.dispose();
  note.dispose();
}

Widget _previewRow(
  String label,
  String value, {
  Color? color,
  bool big = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Color(0xFFA5A8AF), fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            color: color ?? Colors.white,
            fontSize: big ? 16 : 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Future<void> showSaleDialog(
  BuildContext context, {
  String? lockedCat,
  String? lockedProductId,
}) async {
  final MagazinStore store = MagazinScope.of(context);
  String cat = lockedCat ?? '';
  String productId = lockedProductId ?? '';
  final TextEditingController qty = TextEditingController(text: '1');
  final TextEditingController price = TextEditingController();
  final TextEditingController clientName = TextEditingController();
  final TextEditingController clientPhone = TextEditingController();
  String payment = 'naqd';

  Product? currentProduct() {
    if (cat.isEmpty || productId.isEmpty) return null;
    return store.findProduct(cat, productId);
  }

  final Product? locked = currentProduct();
  if (locked != null) {
    price.text = locked.price.round().toString();
  }

  await showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setLocal) {
          final Product? product = currentProduct();
          final int qtyVal = int.tryParse(qty.text) ?? 1;
          final double priceVal = double.tryParse(price.text) ?? 0;
          final bool showPreview = product != null && priceVal > 0;
          final double total = priceVal * qtyVal;
          final double profit = product == null
              ? 0
              : (priceVal - product.cost) * qtyVal;
          final bool belowMin = product != null && priceVal < product.minPrice;

          final List<Product> catProducts = cat.isEmpty
              ? <Product>[]
              : store.byCat(cat).where((Product p) {
                  return p.stock > 0 || p.id == productId;
                }).toList();

          return _withWhiteCursor(
            context,
            AlertDialog(
              backgroundColor: Color(0xFF121212),
              title: Text(
                'Yangi sotuv',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              content: SizedBox(
                width: 520,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Kategoriya'),
                      _darkSelect<String>(
                        selected: cat.isEmpty ? null : cat,
                        hint: 'Tanlang',
                        items: [
                          DropdownMenuItem(
                            value: 'yengil',
                            child: Text('Yengil balon'),
                          ),
                          DropdownMenuItem(
                            value: 'yuk',
                            child: Text('Yuk balon'),
                          ),
                          DropdownMenuItem(value: 'disk', child: Text('Disk')),
                          DropdownMenuItem(
                            value: 'akkum',
                            child: Text('Akkumulyator'),
                          ),
                        ],
                        onChanged: lockedCat == null
                            ? (String? value) {
                                setLocal(() {
                                  cat = value ?? '';
                                  productId = '';
                                  price.text = '';
                                });
                              }
                            : null,
                      ),
                      SizedBox(height: 16),
                      _label('Mahsulot'),
                      _darkSelect<String>(
                        selected: productId.isEmpty ? null : productId,
                        hint: 'Avval kategoriya tanlang',
                        items: catProducts.map((Product p) {
                          return DropdownMenuItem<String>(
                            value: p.id,
                            child: Text(
                              '${p.name} ${p.size} — ${fmtN(p.price)} so\'m | ${p.stock} dona',
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setLocal(() {
                            productId = value ?? '';
                            final Product? selected = currentProduct();
                            if (selected != null) {
                              price.text = selected.price.round().toString();
                            }
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Soni'),
                                _dialogTextField(
                                  controller: qty,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => setLocal(() {}),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.5,
                                  ),
                                  decoration: _fieldDecoration('1'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Sotish narxi (so\'m)'),
                                _dialogTextField(
                                  controller: price,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) => setLocal(() {}),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.5,
                                  ),
                                  decoration: _fieldDecoration('0'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _label('To\'lov turi'),
                      _darkSelect<String>(
                        selected: payment,
                        items: [
                          DropdownMenuItem(
                            value: 'naqd',
                            child: Text('Naqd pul'),
                          ),
                          DropdownMenuItem(
                            value: 'karta',
                            child: Text('Karta (bank)'),
                          ),
                          DropdownMenuItem(
                            value: 'qarz',
                            child: Text('Qarz (nasiya)'),
                          ),
                        ],
                        onChanged: (String? value) {
                          setLocal(() {
                            payment = value ?? 'naqd';
                          });
                        },
                      ),
                      if (payment == 'qarz') ...[
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label('Mijoz ismi'),
                                  _dialogTextField(
                                    controller: clientName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                    ),
                                    decoration: _fieldDecoration(
                                      'Mijoz to\'liq ismi',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label('Telefon'),
                                  _dialogTextField(
                                    controller: clientPhone,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                    ),
                                    decoration: _fieldDecoration(
                                      '+998 90 123 45 67',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (showPreview) ...[
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Color(0x14F97316),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0x40F97316)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _previewRow('Narx (1 dona):', fmtSom(priceVal)),
                              _previewRow('Soni:', '$qtyVal dona'),
                              _previewRow('Jami summa:', fmtSom(total)),
                              Divider(color: Color(0x40F97316)),
                              _previewRow(
                                'Jami foyda:',
                                fmtSom(profit),
                                color: profit < 0
                                    ? Color(0xFFB91C1C)
                                    : Color(0xFF00C853),
                              ),
                              if (belowMin)
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    'Bu narx chegirmadan past! Minimal narxdan past sotmoqdasiz!',
                                    style: TextStyle(
                                      color: Color(0xFFB91C1C),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Bekor qilish'),
                ),
                TextButton(
                  onPressed: () async {
                    final String? error = await store.saveSale(
                      cat: cat,
                      productId: productId,
                      qty: int.tryParse(qty.text) ?? 1,
                      price: double.tryParse(price.text) ?? 0,
                      payment: payment,
                      clientName: clientName.text,
                      clientPhone: clientPhone.text,
                    );
                    if (!dialogContext.mounted) return;
                    if (error != null) {
                      showMagazinSnack(dialogContext, error, isError: true);
                      return;
                    }
                    final Product? sold = store.findProduct(cat, productId);
                    Navigator.pop(dialogContext);
                    showMagazinSnack(
                      context,
                      sold == null
                          ? 'Sotuv qayd etildi!'
                          : 'Sotuv qayd etildi!',
                    );
                  },
                  child: Text('Sotishni tasdiqlash'),
                ),
              ],
            ),
          );
        },
      );
    },
  );

  qty.dispose();
  price.dispose();
  clientName.dispose();
  clientPhone.dispose();
}

Future<void> showDebtDialog(BuildContext context) async {
  final MagazinStore store = MagazinScope.of(context);
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController product = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController paid = TextEditingController(text: '0');
  final TextEditingController note = TextEditingController();

  await showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return _withWhiteCursor(
        dialogContext,
        AlertDialog(
          backgroundColor: Color(0xFF121212),
          title: Text(
            'Qarz qo\'shish',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Mijoz ismi'),
                            _dialogTextField(
                              controller: name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                              ),
                              decoration: _fieldDecoration('To\'liq ism'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Telefon'),

                            _dialogTextField(
                              controller: phone,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [const _UzbekPhoneFormatter()],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                              ),
                              decoration: _fieldDecoration('90 123 45 67')
                                  .copyWith(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 8,
                                      ),
                                      child: Text(
                                        '+998',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.5,
                                        ),
                                      ),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 0,
                                      minHeight: 0,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _label('Mahsulot / Tavsif'),
                  _dialogTextField(
                    controller: product,
                    style: TextStyle(color: Colors.white, fontSize: 13.5),
                    decoration: _fieldDecoration('Nima sotildi'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Qarz miqdori (so\'m)'),
                            _dialogTextField(
                              controller: amount,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                              ),
                              decoration: _fieldDecoration('600000'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Oldindan to\'langan (so\'m)'),
                            _dialogTextField(
                              controller: paid,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                              ),
                              decoration: _fieldDecoration('0'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _label('Izoh'),
                  _dialogTextField(
                    controller: note,
                    style: TextStyle(color: Colors.white, fontSize: 13.5),
                    decoration: _fieldDecoration('Qo\'shimcha ma\'lumot...'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () async {
                final String? error = await store.saveDebt(
                  clientName: name.text,
                  clientPhone: phone.text.isEmpty ? '' : '+998 ${phone.text}',
                  product: product.text,
                  amount: double.tryParse(amount.text) ?? 0,
                  paid: double.tryParse(paid.text) ?? 0,
                  note: note.text,
                );
                if (!dialogContext.mounted) return;
                if (error != null) {
                  showMagazinSnack(dialogContext, error, isError: true);
                  return;
                }
                Navigator.pop(dialogContext);
                showMagazinSnack(context, 'Qarz saqlandi');
              },
              child: Text('Qarzni saqlash'),
            ),
          ],
        ),
      );
    },
  );

  name.dispose();
  phone.dispose();
  product.dispose();
  amount.dispose();
  paid.dispose();
  note.dispose();
}

Future<void> showPayDebtDialog(BuildContext context, DebtRecord debt) async {
  final MagazinStore store = MagazinScope.of(context);
  final TextEditingController amount = TextEditingController(
    text: debt.remaining.round().toString(),
  );

  await showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return _withWhiteCursor(
        dialogContext,
        AlertDialog(
          backgroundColor: Color(0xFF121212),
          title: Text(
            'Qarz to\'lash',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          content: SizedBox(
            width: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${debt.clientName} — ${debt.product.isEmpty ? 'Mahsulot' : debt.product}\n'
                    'Jami qarz: ${fmtSom(debt.amount)}\n'
                    'To\'langan: ${fmtSom(debt.paid)}\n'
                    'Qoldiq: ${fmtSom(debt.remaining)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                _label('To\'lov miqdori (so\'m)'),
                _dialogTextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, fontSize: 13.5),
                  decoration: _fieldDecoration('Qancha to\'lamoqda'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () async {
                final String? error = await store.payDebt(
                  debt.id,
                  double.tryParse(amount.text) ?? 0,
                );
                if (!dialogContext.mounted) return;
                if (error != null) {
                  showMagazinSnack(dialogContext, error, isError: true);
                  return;
                }
                Navigator.pop(dialogContext);
                showMagazinSnack(context, 'To\'lov qabul qilindi!');
              },
              child: Text('To\'lovni qabul qilish'),
            ),
          ],
        ),
      );
    },
  );

  amount.dispose();
}
