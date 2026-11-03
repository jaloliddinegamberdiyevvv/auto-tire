import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class Akkumulyator extends StatelessWidget {
  const Akkumulyator({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'akkum',
      title: 'Akkumulyatorlar',
      sizeColumnTitle: 'MODEL',
      onMenuTap: onMenuTap,
    );
  }
}
