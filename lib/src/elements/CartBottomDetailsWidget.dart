import 'package:flutter/material.dart';
import '../pages/global.dart';
import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../helpers/helper.dart';

class CartBottomDetailsWidget extends StatefulWidget {
  final int situation;

  CartBottomDetailsWidget({
    Key key,
    @required CartController con,
    this.situation,
  })  : _con = con,
        super(key: key);

  final CartController _con;

  @override
  _CartBottomDetailsWidgetState createState() =>
      _CartBottomDetailsWidgetState();
}

class _CartBottomDetailsWidgetState extends State<CartBottomDetailsWidget> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return widget._con.carts.isEmpty
        ? SizedBox(height: 0)
        : Container(
            height: 210,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.15),
                      offset: Offset(0, -2),
                      blurRadius: 5.0)
                ]),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Toplam',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Helper.getPrice(widget._con.subTotal, context,
                            style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  widget._con.carts[0].product.market.deliveryFee == null ||
                          widget._con.carts[0].product.market.deliveryFee == 0
                      ? Container()
                      : Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Poşet Ücreti ',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Poşet Ücreti'),
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Siparişim kaç adet poşet ile gelir ?',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    'Sipariş sırasında sizden sadece 1 adet poşet ücreti tahsil edilir. Ürünlerimizin paketlenmesi esnasında 1 adetten fazla poşet ihtiyacı doğarsa ek poşet ücreti sipariş tutarına yansıtılır.',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(
                                                    'Poşet neden ücretli?',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    '1 Ocak 2019 tarihinde çevre kanununda yapılan yenileme gereği plastik poşetlerin 0.25 tl ücret karşılığı verilmesi zorunlu hale getirilmiştir',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 2),
                                      width: 16,
                                      height: 16,
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (Helper.canDelivery(
                                widget._con.carts[0].product.market,
                                carts: widget._con.carts))
                              Helper.getPrice(
                                  widget
                                      ._con.carts[0].product.market.deliveryFee,
                                  context,
                                  style: Theme.of(context).textTheme.subtitle1)
                            else
                              Helper.getPrice(0, context,
                                  style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                  SizedBox(height: 5),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Teslimat Ücreti',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          'Ücretsiz',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .merge(TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: FlatButton(
                          onPressed: () {
                            if (opacityCheck == 0 && widget.situation == 1) {
                              widget._con.scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                      'Ön bilgilendirme formu ve mesafeli satış sözleşmesini kabul edin.'),
                                ),
                              );
                            } else {
                              widget._con.total <
                                      double.parse(widget
                                          ._con.carts.first.market.minTutar)
                                  ? widget._con.scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                      content: Text(
                                        'Ücretsiz teslim için sepet tutarı minimum tutar dan az olamaz.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ))
                                  : widget._con.goCheckout(context);
                            }
                          },
                          disabledColor:
                              Theme.of(context).focusColor.withOpacity(0.5),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: !widget._con.carts[0].product.market.closed
                              ? widget._con.total <
                                      double.parse(widget
                                          ._con.carts.first.market.minTutar)
                                  ? Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5)
                                  : Theme.of(context).accentColor
                              : Theme.of(context).focusColor.withOpacity(0.5),
                          shape: StadiumBorder(),
                          child: Text(
                            S.of(context).checkout,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Helper.getPrice(
                          widget._con.total,
                          context,
                          style: Theme.of(context).textTheme.headline4.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
  }
}
