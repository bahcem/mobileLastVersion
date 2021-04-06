import 'package:flutter/material.dart';
import '../pages/cart.dart';
import '../pages/login.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class ShoppingCartFloatButtonWidget extends StatefulWidget {
  const ShoppingCartFloatButtonWidget({
    this.iconColor,
    this.labelColor,
    this.product,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;
  final Product product;

  @override
  _ShoppingCartFloatButtonWidgetState createState() =>
      _ShoppingCartFloatButtonWidgetState();
}

class _ShoppingCartFloatButtonWidgetState
    extends StateMVC<ShoppingCartFloatButtonWidget> {
  CartController _con;

  _ShoppingCartFloatButtonWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        color: Theme.of(context).accentColor,
        shape: StadiumBorder(),
        onPressed: () {
          if (currentUser.value.apiToken != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CartWidget(
                  routeArgument:
                      RouteArgument(param: '/Product', id: widget.product.id),
                ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginWidget(),
              ),
            );
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            Icon(
              Icons.shopping_basket,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
            Container(
              child: Center(
                child: Text(
                  _con.cartCount.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption.merge(
                        TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 10),
                      ),
                ),
              ),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: this.widget.labelColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              constraints: BoxConstraints(
                  minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
            ),
          ],
        ),
      ),
    );
//    return FlatButton(
//      onPressed: () {
//
//      },
//      child:
//      color: Colors.transparent,
//    );
  }
}
