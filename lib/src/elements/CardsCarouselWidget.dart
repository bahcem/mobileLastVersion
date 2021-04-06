import 'package:flutter/material.dart';
import '../pages/menu_list.dart';

import '../elements/CardsCarouselLoaderWidget.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import 'CardWidget.dart';

// ignore: must_be_immutable
class CardsCarouselWidget extends StatefulWidget {
  List<Market> marketsList;
  String heroTag;

  CardsCarouselWidget({Key key, this.marketsList, this.heroTag})
      : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.marketsList == null ||
            widget.marketsList.isEmpty ||
            widget.marketsList.length == 0
        ? CardsCarouselLoaderWidget()
        : Container(
            height: 272,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.marketsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {

                    if (widget.marketsList.elementAt(index).closed) {

                    } else {

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MenuWidget(
                            routeArgument: RouteArgument(
                                id: widget.marketsList.elementAt(index).id),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: widget.marketsList.elementAt(index).id ==
                                widget.marketsList
                                    .elementAt(((widget.marketsList.length) - 1)
                                        .toInt())
                                    .id
                            ? 20
                            : 0),
                    child: CardWidget(
                        market: widget.marketsList.elementAt(index),
                        heroTag: widget.heroTag),
                  ),
                );
              },
            ),
          );
  }
}
