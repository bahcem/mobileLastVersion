import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../pages/product.dart';
import '../models/product.dart';
import '../models/route_argument.dart';

class ProductGridItemWidget extends StatefulWidget {
  final String heroTag;
  final Product product;
  final VoidCallback onPressed;

  ProductGridItemWidget({Key key, this.heroTag, this.product, this.onPressed})
      : super(key: key);

  @override
  _ProductGridItemWidgetState createState() => _ProductGridItemWidgetState();
}

class _ProductGridItemWidgetState extends StateMVC<ProductGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductWidget(
              routeArgument: RouteArgument(
                  heroTag: this.widget.heroTag, id: this.widget.product.id),
            ),
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Hero(
                      tag: widget.heroTag + widget.product.id,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage(this.widget.product.image.thumb),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(24)),
                      child: Text(
                        '${widget.product.price.toStringAsFixed(2)} ₺',
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    widget.product.price == null ||
                            widget.product.discountPrice == null ||
                            widget.product.discountPrice == 0.0
                        ? Container()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 36, right: 12),
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 3, bottom: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: Colors.red,
                                    ),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '%${double.parse((((widget.product.discountPrice - widget.product.price) / widget.product.discountPrice) * 100).toString()).toStringAsFixed(0)} indirim',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 12),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.product.name,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                widget.product.market.name,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: widget.onPressed,
                child: Container(
                  margin: EdgeInsets.only(top: 4, left: 6),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.add_rounded,
                    size: 23,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
