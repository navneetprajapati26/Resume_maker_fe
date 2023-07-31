import 'package:flutter/material.dart';
class CustoumCircularIndi extends StatelessWidget {
  const CustoumCircularIndi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        strokeWidth: 1,
        color: Theme.of(context).primaryColor
    );
  }
}
