import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/cart_controller.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class ShoppingCartButtonWidget extends StatefulWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    this.fromWhichPage,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;
  final String fromWhichPage;

  @override
  _ShoppingCartButtonWidgetState createState() => _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState extends StateMVC<ShoppingCartButtonWidget> {
  CartController _con;

  _ShoppingCartButtonWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCartsCount();
    _con.listenForCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (currentUser.value.apiToken != null) {
          Navigator.of(context).pushNamed('/Cart', arguments: RouteArgument(param: '/Pages', id: '2',fromWhichPage: widget.fromWhichPage));
        } else {
          Navigator.of(context).pushNamed('/Login');
        }
      },
      child: Stack(
        children: [
          Container(
            height: 34,
            margin:  EdgeInsets.only(top:  _con.total == 0.0 ? 12 : _con.total == null ? 12 :0  ),
            padding: EdgeInsets.only(
                left: _con.total == 0.0 ? 9  : _con.total == null ? 9 : 6,
                right: _con.total == 0.0 ? 0 : _con.total == null ? 0 : 6,
                top: 1 ,
                bottom: 1),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_basket,
                      color: Theme.of(context).primaryColor,
                      size: 22,
                    ),
                    Container(
                      height: 1,
                      width: 10,
                      color: Colors.transparent,
                    ),
                    _con.total == 0.0
                        ? Container()
                        : _con.total == null
                        ? Container()
                        : Text(
                      _con.total.toStringAsFixed(2) + " ₺",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(
                        TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _con.total == 0.0
              ? Container()
              : _con.total == null
              ? Container()
              : Container(
            margin: EdgeInsets.only(top: 20),
            width: 15,
            height: 15,
            child: Center(
              child: Text(
                _con.cartCount.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.merge(
                  TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 10),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              border: Border.all(
                  color: Theme.of(context).hintColor, width: 0.4),
            ),
          ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}
