import 'package:flutter/material.dart';
import '../controllers/search_controller.dart';
import '../elements/CardWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/ProductGridItemWidget.dart';
import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import 'menu_list.dart';

class SearchHomeWidget extends StatefulWidget {
  @override
  _SearchHomeWidgetState createState() => _SearchHomeWidgetState();
}

class _SearchHomeWidgetState extends StateMVC<SearchHomeWidget> {
  SearchController _con;
  String layout = 'grid';

  _SearchHomeWidgetState() : super(SearchController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).search,
          style: TextStyle(
              color: Color.fromRGBO(255, 228, 121, 1), fontFamily: 'rbt'),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 48,
                color: Colors.white,
                child: TextField(
                  onSubmitted: (text) async {
                    await _con.refreshSearch(text);
                    _con.saveSearch(text);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).search_for_markets_or_products,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .merge(TextStyle(fontSize: 14)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1))),
                  ),
                ),
              ),
            ),
            _con.markets.isEmpty && _con.products.isEmpty
                ? CircularLoadingWidget(height: 218)
                : Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            title: Text(
                              S.of(context).products_results,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: this.layout != 'grid',
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 2
                                    : 4,
                            children:
                                List.generate(_con.products.length, (index) {
                              return ProductGridItemWidget(
                                heroTag: 'favorites_grid',
                                product: _con.products.elementAt(index),
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            title: Text(
                              S.of(context).markets_results,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.markets.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) => MenuWidget(
                                            routeArgument: RouteArgument(
                                              id: _con.markets
                                                  .elementAt(index)
                                                  .id,
                                              heroTag: 'search',
                                            ),
                                          ),
                                      fullscreenDialog: true),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 20),
                                child: CardWidget(
                                    market: _con.markets.elementAt(index),
                                    heroTag: 'search'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
