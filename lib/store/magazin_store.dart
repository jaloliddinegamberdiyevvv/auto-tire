import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// shared_preferences — HTML dagi localStorage o‘rniga ishlatiladi
import 'package:shared_preferences/shared_preferences.dart';

// Mahsulot modeli (kategoriya ichidagi bitta qator).
class Product {
  String id;
  String name;
  String size;
  double cost;
  double price;
  double maxDiscount;
  int stock;
  String note;
  String createdAt;

  Product({
    required this.id,
    required this.name,
    required this.size,
    required this.cost,
    required this.price,
    required this.maxDiscount,
    required this.stock,
    required this.note,
    required this.createdAt,
  });

  // Asosiy foyda: sotish − kelish.
  double get profit => price - cost;

  // Chegirma bilan minimal foyda.
  double get minProfit => price - maxDiscount - cost;

  // Chegirmadan keyingi eng past sotish narxi.
  double get minPrice => price - maxDiscount;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'cost': cost,
      'price': price,
      'maxDiscount': maxDiscount,
      'stock': stock,
      'note': note,
      'createdAt': createdAt,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      size: json['size'] as String? ?? '',
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      maxDiscount: (json['maxDiscount'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      note: json['note'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }
}

// Bitta sotuv qaydi.
class SaleRecord {
  String id;
  String date;
  String dateKey;
  String cat;
  String productId;
  String productName;
  int qty;
  double unitPrice;
  double total;
  double cost;
  double profit;
  String payment;

  SaleRecord({
    required this.id,
    required this.date,
    required this.dateKey,
    required this.cat,
    required this.productId,
    required this.productName,
    required this.qty,
    required this.unitPrice,
    required this.total,
    required this.cost,
    required this.profit,
    required this.payment,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'dateKey': dateKey,
      'cat': cat,
      'productId': productId,
      'productName': productName,
      'qty': qty,
      'unitPrice': unitPrice,
      'total': total,
      'cost': cost,
      'profit': profit,
      'payment': payment,
    };
  }

  static SaleRecord fromJson(Map<String, dynamic> json) {
    return SaleRecord(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      dateKey: json['dateKey'] as String? ?? '',
      cat: json['cat'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      profit: (json['profit'] as num?)?.toDouble() ?? 0,
      payment: json['payment'] as String? ?? 'naqd',
    );
  }
}

// Qarz qaydi.
class DebtRecord {
  String id;
  String clientName;
  String clientPhone;
  String product;
  double amount;
  double paid;
  String date;
  String status;
  String note;

  DebtRecord({
    required this.id,
    required this.clientName,
    required this.clientPhone,
    required this.product,
    required this.amount,
    required this.paid,
    required this.date,
    required this.status,
    required this.note,
  });

  double get remaining => amount - paid;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'product': product,
      'amount': amount,
      'paid': paid,
      'date': date,
      'status': status,
      'note': note,
    };
  }

  static DebtRecord fromJson(Map<String, dynamic> json) {
    return DebtRecord(
      id: json['id'] as String? ?? '',
      clientName: json['clientName'] as String? ?? '',
      clientPhone: json['clientPhone'] as String? ?? '',
      product: json['product'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      paid: (json['paid'] as num?)?.toDouble() ?? 0,
      date: json['date'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      note: json['note'] as String? ?? '',
    );
  }
}

// Raqamlarni 1 200 000 ko‘rinishida chiqarish.
String fmtN(num n) {
  final String raw = n.round().abs().toString();
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < raw.length; i++) {
    final int fromEnd = raw.length - i;
    if (i > 0 && fromEnd % 3 == 0) {
      buffer.write(' ');
    }
    buffer.write(raw[i]);
  }
  final String body = buffer.toString();
  if (n < 0) {
    return '-$body';
  }
  return body;
}

String fmtSom(num n) {
  return '${fmtN(n)} so\'m';
}

// Katta summani 1.20M ko‘rinishida chiqarish.
String fmtMillion(num n, {int digits = 2}) {
  return '${(n / 1000000).toStringAsFixed(digits)}M';
}

String todayKey() {
  final DateTime now = DateTime.now();
  final String day = now.day.toString().padLeft(2, '0');
  final String month = now.month.toString().padLeft(2, '0');
  return '$day.$month.${now.year}';
}

String nowLabel() {
  final DateTime now = DateTime.now();
  final String hour = now.hour.toString().padLeft(2, '0');
  final String minute = now.minute.toString().padLeft(2, '0');
  return '${todayKey()} $hour:$minute';
}

String newUid() {
  // DateTime + Random — HTML dagi uid() o‘rniga.
  return DateTime.now().millisecondsSinceEpoch.toRadixString(36) +
      Random().nextInt(0xffffff).toRadixString(36);
}

String categoryLabel(String cat) {
  if (cat == 'yengil') return 'Yengil balon';
  if (cat == 'yuk') return 'Yuk balon';
  if (cat == 'disk') return 'Disk';
  if (cat == 'akkum') return 'Akkumulyator';
  return cat;
}

String paymentLabel(String payment) {
  if (payment == 'naqd') return 'Naqd';
  if (payment == 'karta') return 'Karta';
  if (payment == 'qarz') return 'Nasiya';
  return payment;
}

String debtStatusLabel(String status) {
  if (status == 'pending') return 'To\'lanmagan';
  if (status == 'partial') return 'Qisman';
  if (status == 'paid') return 'To\'langan';
  return status;
}

// ChangeNotifier — sahifalar o‘zgarishni eshitishi uchun.
class MagazinStore extends ChangeNotifier {
  // shared_preferences kaliti (HTML dagi autotire-data).
  final String _storageKey = 'autotire-data';

  Map<String, List<Product>> products = {
    'yengil': <Product>[],
    'yuk': <Product>[],
    'disk': <Product>[],
    'akkum': <Product>[],
  };

  List<SaleRecord> sales = <SaleRecord>[];
  List<DebtRecord> debts = <DebtRecord>[];

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? saved = prefs.getString(_storageKey);
    if (saved == null || saved.isEmpty) {
      notifyListeners();
      return;
    }

    final Map<String, dynamic> data =
        jsonDecode(saved) as Map<String, dynamic>;
    final Map<String, dynamic> rawProducts =
        (data['products'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    products = {
      'yengil': _parseProducts(rawProducts['yengil']),
      'yuk': _parseProducts(rawProducts['yuk']),
      'disk': _parseProducts(rawProducts['disk']),
      'akkum': _parseProducts(rawProducts['akkum']),
    };

    sales = ((data['sales'] as List<dynamic>?) ?? <dynamic>[])
        .map((dynamic item) => SaleRecord.fromJson(item as Map<String, dynamic>))
        .toList();

    debts = ((data['debts'] as List<dynamic>?) ?? <dynamic>[])
        .map((dynamic item) => DebtRecord.fromJson(item as Map<String, dynamic>))
        .toList();

    notifyListeners();
  }

  List<Product> _parseProducts(dynamic raw) {
    if (raw is! List) {
      return <Product>[];
    }
    return raw
        .map((dynamic item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _persist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = {
      'products': {
        'yengil': products['yengil']!.map((Product p) => p.toJson()).toList(),
        'yuk': products['yuk']!.map((Product p) => p.toJson()).toList(),
        'disk': products['disk']!.map((Product p) => p.toJson()).toList(),
        'akkum': products['akkum']!.map((Product p) => p.toJson()).toList(),
      },
      'sales': sales.map((SaleRecord s) => s.toJson()).toList(),
      'debts': debts.map((DebtRecord d) => d.toJson()).toList(),
    };
    await prefs.setString(_storageKey, jsonEncode(data));
  }

  List<Product> byCat(String cat) {
    return products[cat] ?? <Product>[];
  }

  List<Product> get allProducts {
    return products.values.expand((List<Product> list) => list).toList();
  }

  Product? findProduct(String cat, String id) {
    for (final Product p in byCat(cat)) {
      if (p.id == id) {
        return p;
      }
    }
    return null;
  }

  Future<String?> saveProduct({
    required String cat,
    String? editId,
    required String name,
    required String size,
    required double cost,
    required double price,
    required double maxDiscount,
    required int stock,
    required String note,
  }) async {
    if (name.isEmpty || cost <= 0 || price <= 0) {
      return 'Iltimos barcha maydonlarni to\'ldiring';
    }
    if (price < cost) {
      return 'Sotish narxi kelish narxidan past bo\'lmasin!';
    }

    if (editId != null && editId.isNotEmpty) {
      final Product? existing = findProduct(cat, editId);
      if (existing != null) {
        existing.name = name;
        existing.size = size;
        existing.cost = cost;
        existing.price = price;
        existing.maxDiscount = maxDiscount;
        existing.stock = stock;
        existing.note = note;
      }
    } else {
      products[cat]!.add(
        Product(
          id: newUid(),
          name: name,
          size: size,
          cost: cost,
          price: price,
          maxDiscount: maxDiscount,
          stock: stock,
          note: note,
          createdAt: todayKey(),
        ),
      );
    }

    await _persist();
    notifyListeners();
    return null;
  }

  Future<void> deleteProduct(String cat, String id) async {
    products[cat] = byCat(cat).where((Product p) => p.id != id).toList();
    await _persist();
    notifyListeners();
  }

  Future<String?> saveSale({
    required String cat,
    required String productId,
    required int qty,
    required double price,
    required String payment,
    String clientName = '',
    String clientPhone = '',
  }) async {
    if (cat.isEmpty || productId.isEmpty || price <= 0 || qty < 1) {
      return 'Barcha maydonlarni to\'ldiring';
    }

    final Product? product = findProduct(cat, productId);
    if (product == null) {
      return 'Mahsulot topilmadi';
    }
    if (product.stock < qty) {
      return 'Omborda yetarli mahsulot yo\'q!';
    }
    if (payment == 'qarz' && clientName.trim().isEmpty) {
      return 'Mijoz ismini kiriting';
    }

    final SaleRecord sale = SaleRecord(
      id: newUid(),
      date: nowLabel(),
      dateKey: todayKey(),
      cat: cat,
      productId: productId,
      productName: product.size.isEmpty
          ? product.name
          : '${product.name} ${product.size}',
      qty: qty,
      unitPrice: price,
      total: price * qty,
      cost: product.cost,
      profit: (price - product.cost) * qty,
      payment: payment,
    );

    if (payment == 'qarz') {
      debts.add(
        DebtRecord(
          id: newUid(),
          clientName: clientName.trim(),
          clientPhone: clientPhone.trim(),
          product: sale.productName,
          amount: sale.total,
          paid: 0,
          date: sale.date,
          status: 'pending',
          note: '',
        ),
      );
    }

    product.stock -= qty;
    sales.insert(0, sale);
    await _persist();
    notifyListeners();
    return null;
  }

  Future<void> deleteSale(String id) async {
    sales = sales.where((SaleRecord s) => s.id != id).toList();
    await _persist();
    notifyListeners();
  }

  Future<String?> saveDebt({
    required String clientName,
    required String clientPhone,
    required String product,
    required double amount,
    required double paid,
    required String note,
  }) async {
    if (clientName.trim().isEmpty || amount <= 0) {
      return 'Ism va miqdorni kiriting';
    }

    String status = 'pending';
    if (paid >= amount) {
      status = 'paid';
    } else if (paid > 0) {
      status = 'partial';
    }

    debts.add(
      DebtRecord(
        id: newUid(),
        clientName: clientName.trim(),
        clientPhone: clientPhone.trim(),
        product: product.trim(),
        amount: amount,
        paid: paid,
        date: todayKey(),
        status: status,
        note: note.trim(),
      ),
    );

    await _persist();
    notifyListeners();
    return null;
  }

  Future<String?> payDebt(String id, double amount) async {
    if (amount <= 0) {
      return 'To\'lov miqdorini kiriting';
    }

    DebtRecord? debt;
    for (final DebtRecord item in debts) {
      if (item.id == id) {
        debt = item;
        break;
      }
    }
    if (debt == null) {
      return 'Qarz topilmadi';
    }

    debt.paid += amount;
    if (debt.paid >= debt.amount) {
      debt.paid = debt.amount;
      debt.status = 'paid';
    } else if (debt.paid > 0) {
      debt.status = 'partial';
    }

    await _persist();
    notifyListeners();
    return null;
  }

  Future<void> deleteDebt(String id) async {
    debts = debts.where((DebtRecord d) => d.id != id).toList();
    await _persist();
    notifyListeners();
  }

  int get pendingDebtCount {
    return debts.where((DebtRecord d) => d.status != 'paid').length;
  }

  double get pendingDebtSum {
    double sum = 0;
    for (final DebtRecord d in debts) {
      if (d.status != 'paid') {
        sum += d.remaining;
      }
    }
    return sum;
  }

  double get paidDebtSum {
    double sum = 0;
    for (final DebtRecord d in debts) {
      sum += d.paid;
    }
    return sum;
  }

  int get debtClientCount {
    final Set<String> names = <String>{};
    for (final DebtRecord d in debts) {
      if (d.status != 'paid') {
        names.add(d.clientName);
      }
    }
    return names.length;
  }

  double get totalProfit {
    double sum = 0;
    for (final SaleRecord s in sales) {
      sum += s.profit;
    }
    return sum;
  }

  double get totalRevenue {
    double sum = 0;
    for (final SaleRecord s in sales) {
      sum += s.total;
    }
    return sum;
  }

  List<SaleRecord> get todaySales {
    final String key = todayKey();
    return sales.where((SaleRecord s) => s.dateKey == key).toList();
  }

  double get warehouseValue {
    double sum = 0;
    for (final Product p in allProducts) {
      sum += p.cost * p.stock;
    }
    return sum;
  }

  int get warehouseStock {
    int sum = 0;
    for (final Product p in allProducts) {
      sum += p.stock;
    }
    return sum;
  }
}

// InheritedNotifier — MagazinStore ni butun daraxtga ulash uchun.
class MagazinScope extends InheritedNotifier<MagazinStore> {
  MagazinScope({
    super.key,
    required MagazinStore store,
    required super.child,
  }) : super(notifier: store);

  static MagazinStore of(BuildContext context) {
    final MagazinScope scope =
        context.dependOnInheritedWidgetOfExactType<MagazinScope>()!;
    return scope.notifier!;
  }
}
