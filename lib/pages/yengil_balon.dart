import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class YengilBalon extends StatelessWidget {
  YengilBalon({super.key});

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'yengil',
      title: 'Yengil avtomobil balonlari',
      sizeColumnTitle: 'RAZMER',
    );
  }
}
