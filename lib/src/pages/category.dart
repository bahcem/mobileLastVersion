import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EmptyCategoryWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/category_controller.dart';
import '../elements/FilterWidget.dart';
import '../elements/ProductGridItemWidget.dart';
import '../elements/ProductListItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/route_argument.dart';

class CategoryWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CategoryWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends StateMVC<CategoryWidget> {
  String layout = 'grid';

  CategoryController _con;
  double _marginLeft = 0;
  var lastIndex = "0";

  _CategoryWidgetState() : super(CategoryController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProductsByCategory(id: widget.routeArgument.id);
    _con.listenForCategory(id: widget.routeArgument.id);
    _con.listenForCart();
    _con.listenForCategories();
    setState(() {
      lastIndex = widget.routeArgument.id;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      // drawer: DrawerWidget(),
      endDrawer: FilterWidget(onFilter: (filter) {
        Navigator.of(context).pushReplacementNamed('/Category',
            arguments: RouteArgument(id: widget.routeArgument.id));
      }),
      appBar: AppBar(
        bottom: _con.category == null && _con.products.isEmpty
            ? PreferredSize(
                preferredSize: Size.fromHeight(0.8),
                child: LinearProgressIndicator(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.2),
                ),
              )
            : PreferredSize(
                child: Container(
                  color: Theme.of(context).focusColor.withOpacity(0.3),
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(4.0),
              ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).category,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 0)),
        ),
        actions: <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _con.refreshCategory(lastIndex);
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: this._con.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            lastIndex = "0";
                          });
                          var resp = await _con
                              .refreshCategory(_con.categories[index].id);
                          setState(() {
                            lastIndex = resp;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Hero(
                              tag: _con.categories[index].id,
                              child: Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: this._marginLeft, end: 20),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: lastIndex ==
                                            _con.categories[index].id.toString()
                                        ? Border.all(
                                            color:
                                                Theme.of(context).accentColor,
                                            width: 1)
                                        : Border.all(
                                            color: Colors.transparent,
                                            width: 0),
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2),
                                          offset: Offset(0, 2),
                                          blurRadius: 7.0)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: _con.categories[index].image.url
                                          .toLowerCase()
                                          .endsWith('.svg')
                                      ? SvgPicture.network(
                                          _con.categories[index].image.url,
                                          color: Theme.of(context).accentColor,
                                        )
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              _con.categories[index].image.icon,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: this._marginLeft, end: 20),
                              child: Text(
                                _con.categories[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: lastIndex ==
                                        _con.categories[index].id.toString()
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .merge(
                                          TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor, fontWeight: FontWeight.w700),
                                        )
                                    : Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
              lastIndex == "0"
                  ? CircularLoadingWidget(
                      height: 300,
                    )
                  : _con.products.isEmpty
                      ? EmptyCategoryWidget()
                      : Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                title: Text(
                                  _con.category?.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          this.layout = 'list';
                                        });
                                      },
                                      icon: Icon(
                                        Icons.format_list_bulleted,
                                        color: this.layout == 'list'
                                            ? Theme.of(context).accentColor
                                            : Theme.of(context).focusColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          this.layout = 'grid';
                                        });
                                      },
                                      icon: Icon(
                                        Icons.apps,
                                        color: this.layout == 'grid'
                                            ? Theme.of(context).accentColor
                                            : Theme.of(context).focusColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Offstage(
                              offstage: this.layout != 'list',
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: _con.products.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 10);
                                },
                                itemBuilder: (context, index) {
                                  return ProductListItemWidget(
                                    heroTag: 'favorites_list',
                                    product: _con.products.elementAt(index),
                                  );
                                },
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
                                // Create a grid with 2 columns. If you change the scrollDirection to
                                // horizontal, this produces 2 rows.
                                crossAxisCount:
                                    MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? 2
                                        : 4,
                                // Generate 100 widgets that display their index in the List.
                                children: List.generate(_con.products.length,
                                    (index) {
                                  return ProductGridItemWidget(
                                    heroTag: 'category_grid',
                                    product: _con.products.elementAt(index),
                                    //                              onPressed: () {
                                    //                                if (currentUser.value.apiToken == null) {
                                    //                                  Navigator.of(context).pushNamed('/Login');
                                    //                                } else {
                                    //                                  if (_con.isSameMarkets(_con.products.elementAt(index))) {
                                    //                                    _con.addToCart(_con.products.elementAt(index));
                                    //                                  } else {
                                    //                                    showDialog(
                                    //                                      context: context,
                                    //                                      builder: (BuildContext context) {
                                    //                                        // return object of type Dialog
                                    //                                        return AddToCartAlertDialogWidget(
                                    //                                            oldProduct: _con.carts.elementAt(0)?.product,
                                    //                                            newProduct: _con.products.elementAt(index),
                                    //                                            onPressed: (product, {reset: true}) {
                                    //                                              return _con.addToCart(_con.products.elementAt(index), reset: true);
                                    //                                            });
                                    //                                      },
                                    //                                    );
                                    //                                  }
                                    //                                }
                                    //                              }
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
