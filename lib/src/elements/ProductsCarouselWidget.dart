import 'package:flutter/material.dart';

import '../elements/ProductsCarouselItemWidget.dart';
import '../elements/ProductsCarouselLoaderWidget.dart';
import '../models/product.dart';

class ProductsCarouselWidget extends StatelessWidget {
  final List<Product> productsList;
  final String heroTag;

  ProductsCarouselWidget({Key key, this.productsList, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productsList.isEmpty
        ? ProductsCarouselLoaderWidget()
        : Container(
            height: 190,
            padding: EdgeInsets.only(top: 10,bottom: 0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return ProductsCarouselItemWidget(
                  heroTag: heroTag,
                  marginLeft: _marginLeft,
                  product: productsList.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            ));
  }
}
