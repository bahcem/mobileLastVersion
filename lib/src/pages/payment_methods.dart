import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../elements/PaymentMethodListItemWidget.dart';
import '../models/payment_method.dart';
import '../models/route_argument.dart';

class PaymentMethodsWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  PaymentMethodsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _PaymentMethodsWidgetState createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  PaymentMethodList list;

  @override
  Widget build(BuildContext context) {
    list = new PaymentMethodList(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
          new Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ödeme Yöntemi',
          style: TextStyle(
              color: Color.fromRGBO(255, 228, 121, 1), fontFamily: 'rbt'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 15),
            list.paymentsList.length > 0
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),

                title: Text(
                  S.of(context).payment_options,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(S.of(context).select_your_preferred_payment_mode),
              ),
            )
                : SizedBox(
              height: 0,
            ),
            SizedBox(height: 10),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: list.cashList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return PaymentMethodListItemWidget(paymentMethod: list.cashList.elementAt(index));
              },
            ),
          ],
        ),
      ),
    );
  }
}
