import 'package:auto_tire/pages/mahsulot_sahifa.dart';
import 'package:flutter/material.dart';

class Diskalar extends StatelessWidget {
  const Diskalar({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return MahsulotSahifa(
      category: 'disk',
      title: 'Diskalar',
      sizeColumnTitle: 'RAZMER',
      onMenuTap: onMenuTap,
    );
  }
}
