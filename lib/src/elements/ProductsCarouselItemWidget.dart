import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../pages/product.dart';

import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/route_argument.dart';

class ProductsCarouselItemWidget extends StatelessWidget {
  final double marginLeft;
  final Product product;
  final String heroTag;

  ProductsCarouselItemWidget(
      {Key key, this.heroTag, this.marginLeft, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () async {
        await Navigator.of(context, rootNavigator: false).push(
          MaterialPageRoute(
              builder: (context) => ProductWidget(
                    routeArgument: RouteArgument(
                        id: product.id,
                        heroTag: this.heroTag,
                        fromWhichPage: 'menu_list'),
                  ),
              fullscreenDialog: false),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + product.id,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.15),
                        offset: Offset(0, 5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  margin: EdgeInsetsDirectional.only(
                      start: this.marginLeft, end: 20),
                  width: 100,
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.image.thumb,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.topEnd,
                child: Helper.getPrice(
                  product.price,
                  context,
                  style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12)),
                ),
              ),
              product.price == null ||
                      product.discountPrice == null ||
                      product.discountPrice == 0.0
                  ? Container()
                  : Container(
                      margin: EdgeInsetsDirectional.only(end: 25, top: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.red,
                      ),
                      alignment: AlignmentDirectional.topEnd,
                      child: Text(
                        '%${double.parse((((product.discountPrice - product.price) / product.discountPrice) * 100).toString()).toStringAsFixed(0)} indirim',
                        style: Theme.of(context).textTheme.bodyText1.merge(
                            TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12)),
                      ),
                    ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,
              margin:
                  EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.product.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    product.market.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
