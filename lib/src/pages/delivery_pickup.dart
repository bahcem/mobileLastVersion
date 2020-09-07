import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/EmptyDeliverWidget.dart';
import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/DeliveryAddressDialog.dart';
import '../elements/DeliveryAddressesItemWidget.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/payment_method.dart';
import '../models/route_argument.dart';

class DeliveryPickupWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  DeliveryPickupWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DeliveryPickupWidgetState createState() => _DeliveryPickupWidgetState();
}

class _DeliveryPickupWidgetState extends StateMVC<DeliveryPickupWidget> {
  DeliveryPickupController _con;

  double opacityCheck = 1;

  _DeliveryPickupWidgetState() : super(DeliveryPickupController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (_con.list == null) {
      _con.list = new PaymentMethodList(context);
//      widget.pickup = widget.list.pickupList.elementAt(0);
//      widget.delivery = widget.list.pickupList.elementAt(1);
    }
    return Scaffold(
      key: _con.scaffoldKey,
      bottomNavigationBar: CartBottomDetailsWidget(con: _con),
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).focusColor.withOpacity(0.3),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).delivery_or_pickup,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(left: 20, right: 10),
//              child: ListTile(
//                contentPadding: EdgeInsets.symmetric(vertical: 0),
//                leading: Icon(
//                  Icons.domain,
//                  color: Theme.of(context).hintColor,
//                ),
//                title: Text(
//                  S.of(context).pickup,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
//                  style: Theme.of(context).textTheme.headline4,
//                ),
//                subtitle: Text(
//                  S.of(context).pickup_your_product_from_the_market,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
//                  style: Theme.of(context).textTheme.caption,
//                ),
//              ),
//            ),
            //  PickUpMethodItem(
            //                paymentMethod: _con.getPickUpMethod(),
            //                onPressed: (paymentMethod) {
            //                  _con.togglePickUp();
            //                }),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 10, left: 20, right: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    title: Text(
                      S.of(context).delivery,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: _con.carts.isNotEmpty &&
                        Helper.canDelivery(_con.carts[0].product.market,
                            carts: _con.carts)
                        ? Text(
                      S
                          .of(context)
                          .click_to_confirm_your_address_and_pay_or_long_press,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    )
                        : Text(
                      "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                _con.carts.isNotEmpty &&
                    Helper.canDelivery(_con.carts[0].product.market,
                        carts: _con.carts)
                    ? DeliveryAddressesItemWidget(
                  paymentMethod: _con.getDeliveryMethod(),
                  address: _con.deliveryAddress,
                  onPressed: (Address _address) {
                    if (_con.deliveryAddress.id == null ||
                        _con.deliveryAddress.id == 'null') {
                      DeliveryAddressDialog(
                        context: context,
                        address: _address,
                        onChanged: (Address _address) {
                          _con.addAddress(_address);
                        },
                      );
                    } else {
                      _con.toggleDelivery();
                    }
                  },
                  onLongPress: (Address _address) {
                    DeliveryAddressDialog(
                      context: context,
                      address: _address,
                      onChanged: (Address _address) {
                        _con.updateAddress(_address);
                      },
                    );
                  },
                )
                    : EmptyDeliverWidget(),
                _con.carts.isEmpty
                    ? Container()
                    : Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context)
                              .focusColor
                              .withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 1.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        margin: EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {},
                          child: Opacity(
                            opacity: opacityCheck,
                            child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Theme.of(context).primaryColor,
                                  size: 24,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text:
                                "Ön bilgilendirme formu ve mesafeli satış sözleşmesi",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "'ni okudum ve kabul ediyorum.",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ]),
                          )),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
