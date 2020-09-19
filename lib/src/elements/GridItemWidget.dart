import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/market.dart';
import '../models/route_argument.dart';

class GridItemWidget extends StatelessWidget {
  final Market market;
  final String heroTag;

  GridItemWidget({Key key, this.market, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: market.id, heroTag: heroTag, fromWhichPage: 'popular_markets'));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)]),
        child: Wrap(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Hero(
                tag: heroTag + market.id,
                child: CachedNetworkImage(
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: market.image.thumb,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 82,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    market.name,
                    style: Theme.of(context).textTheme.bodyText2,
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: market.name.length >= 20 ? 2 : 18),
                  Row(
                    children: Helper.getStarsList(double.parse(market.rate)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
