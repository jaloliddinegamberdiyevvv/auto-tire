import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class YengilBalon extends StatelessWidget {
  const YengilBalon({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'yengil',
      title: 'Yengil avtomobil balonlari',
      sizeColumnTitle: 'RAZMER',
      onMenuTap: onMenuTap,
    );
  }
}
