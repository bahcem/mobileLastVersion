import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../repository/user_repository.dart';

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
          bottom: _con.orders.isEmpty
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
        //leading: new IconButton(
        //          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
        //          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        //        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).my_orders,
          style: TextStyle(
              color: Color.fromRGBO(255, 228, 121, 1), fontFamily: 'rbt'),
        ),

      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : _con.orders.isEmpty
              ? EmptyOrdersWidget()
              : RefreshIndicator(
                  onRefresh: _con.refreshOrders,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[

                        SizedBox(height: 10),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.orders.length,
                          itemBuilder: (context, index) {
                            var _order = _con.orders.elementAt(index);
                            return OrderItemWidget(
                              expanded: index == 0 ? true : false,
                              order: _order,
                              onCanceled: (e) {
                                _con.doCancelOrder(_order);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
