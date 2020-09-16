import 'dart:ui';

import 'package:flutter/material.dart';

class HomeSliderLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.15),
              blurRadius: 15,
              offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset('assets/img/loading.gif', fit: BoxFit.cover),
      ),
    );
  }
}
