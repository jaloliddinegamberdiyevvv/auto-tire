import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class YukBalon extends StatelessWidget {
  const YukBalon({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'yuk',
      title: 'Yuk mashina balonlari',
      sizeColumnTitle: 'RAZMER',
      onMenuTap: onMenuTap,
    );
  }
}
