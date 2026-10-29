import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class Akkumulyator extends StatelessWidget {
  Akkumulyator({super.key});

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'akkum',
      title: 'Akkumulyatorlar',
      sizeColumnTitle: 'MODEL',
    );
  }
}
