import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class Diskalar extends StatelessWidget {
  Diskalar({super.key});

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'disk',
      title: 'Diskalar',
      sizeColumnTitle: 'RAZMER',
    );
  }
}
