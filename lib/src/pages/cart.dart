import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/menu_list.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/CartItemWidget.dart';
import '../elements/EmptyCartWidget.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class CartWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CartWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends StateMVC<CartWidget> {
  CartController _con;

  _CartWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        Navigator.pop(context);
      },
      child: Scaffold(
        key: _con.scaffoldKey,
        bottomNavigationBar: CartBottomDetailsWidget(con: _con),
        appBar: AppBar(
          bottom: _con.carts.isEmpty
              ? PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(),
                )
              : PreferredSize(
                  child: Container(
                    color: Theme.of(context).focusColor.withOpacity(0.3),
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(4.0),
                ),
          automaticallyImplyLeading: false,
          leading: widget.routeArgument == null
              ? Container()
              : IconButton(
                  onPressed: () async {
                    if (widget.routeArgument.param == '/Product') {
                      Navigator.pop(context);
                    } else if (widget.routeArgument.fromWhichPage ==
                        'not_home') {
                      Navigator.pop(context);
                    } else if (widget.routeArgument.fromWhichPage !=
                            'not_home' ||
                        widget.routeArgument.fromWhichPage != "" ||
                        widget.routeArgument.fromWhichPage != null) {
                      print(widget.routeArgument.fromWhichPage);
                      await Navigator.of(context, rootNavigator: false).push(
                        MaterialPageRoute(
                            builder: (context) => MenuWidget(
                                  routeArgument: RouteArgument(
                                      id: widget.routeArgument.fromWhichPage),
                                ),
                            fullscreenDialog: false),
                      );
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => CartWidget(
                                routeArgument: RouteArgument(
                                    param: '/Pages',
                                    id: '2',
                                    fromWhichPage:
                                        widget.routeArgument.fromWhichPage)),
                            fullscreenDialog: true),
                      );
                    }
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Theme.of(context).primaryColor,
                ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).cart,
            style: TextStyle(
                color: Color.fromRGBO(255, 228, 121, 1), fontFamily: 'rbt'),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _con.refreshCarts();
                }),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _con.refreshCarts,
          child: _con.carts.isEmpty
              ? EmptyCartWidget()
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: true,
                      itemCount: _con.carts.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            index == 0 &&
                                    _con.carts.first.market.minTutar != null &&
                                    _con.carts.first.market.minTutar !=
                                        'null' &&
                                    _con.carts.first.market.minTutar != ''
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    width: MediaQuery.of(context).size.width,
                                    height: 48,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Minimum sepet tutarı: ${_con.carts.first.market.minTutar} tl',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: CartItemWidget(
                                cart: _con.carts.elementAt(index),
                                heroTag: 'cart',
                                increment: () {
                                  _con.incrementQuantity(
                                      _con.carts.elementAt(index));
                                },
                                decrement: () {
                                  _con.decrementQuantity(
                                      _con.carts.elementAt(index));
                                },
                                onDismissed: () {
                                  _con.removeFromCart(
                                      _con.carts.elementAt(index));
                                },
                              ),
                            ),
                            index == _con.carts.length - 1
                                ? Container(
                                    padding: const EdgeInsets.all(18),
                                    margin: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.15),
                                              offset: Offset(0, 2),
                                              blurRadius: 5.0)
                                        ]),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      onSubmitted: (String value) {
                                        _con.doApplyCoupon(value);
                                      },
                                      cursorColor:
                                          Theme.of(context).accentColor,
                                      controller: TextEditingController()
                                        ..text = coupon?.code ?? '',
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        suffixText: coupon?.valid == null
                                            ? ''
                                            : (coupon.valid
                                                ? S.of(context).validCouponCode
                                                : S
                                                    .of(context)
                                                    .invalidCouponCode),
                                        suffixStyle: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .merge(TextStyle(
                                                color:
                                                    _con.getCouponIconColor())),
                                        suffixIcon: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Icon(
                                              Icons.confirmation_number,
                                              color: _con.getCouponIconColor(),
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                        hintText: S.of(context).haveCouponCode,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.2))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.5))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.2))),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
