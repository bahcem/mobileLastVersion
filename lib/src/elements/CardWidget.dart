import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../pages/map.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  Market market;
  String heroTag;

  CardWidget({Key key, this.market, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 0, top: 5, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Hero(
                tag: this.heroTag + market.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: market.image.url,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      market.closed
                          ? Container(
                              width: 330,
                              height: 150,
                              color: Colors.black.withOpacity(0.6),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                        color: market.closed ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(24)),
                    child: market.closed
                        ? Text(
                            S.of(context).closed,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          )
                        : Text(
                            S.of(context).open,
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                        color: market.closed ? Colors.grey : Colors.red,
                        borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      'min: ${market.minTutar == 'null' || market.minTutar == null ? '-' : market.minTutar} ₺',
                      style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        market.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: market.closed
                            ? Theme.of(context).textTheme.subtitle1.merge(
                                  TextStyle(color: Colors.grey),
                                )
                            : Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        '',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children:
                            Helper.getStarsList(double.parse(market.rate)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MapWidget(
                                  routeArgument: new RouteArgument(
                                      id: '1', param: market)),
                            ),
                          );
                        },
                        child: Icon(Icons.directions,
                            color: Theme.of(context).primaryColor),
                        color: market.closed
                            ? Colors.grey
                            : Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      market.distance > 0
                          ? Text(
                              Helper.getDistance(
                                  market.distance,
                                  Helper.of(context)
                                      .trans(setting.value.distanceUnit)),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: market.closed ? Colors.grey : null),
                            )
                          : SizedBox(height: 0)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
