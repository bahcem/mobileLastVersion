import 'package:flutter/material.dart';
import '../elements/AddToCartAlertDialog.dart';
import '../repository/user_repository.dart';
import '../elements/ProductGridItemWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import 'global.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
  final RouteArgument routeArgument;

  MenuWidget({Key key, this.routeArgument}) : super(key: key);
}

class _MenuWidgetState extends StateMVC<MenuWidget> {
  MarketController _con;
  String layout = 'grid';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _MenuWidgetState() : super(MarketController()) {
    _con = controller;
  }

  getMarketData() async {
    print('GİRDİM');
    refreshGlobal = false;
    _con.market = (new Market())..id = widget.routeArgument.id;

    print(_con.market.id);
    print(_con.market.name);
    print(_con.market.toMap());
    print(widget.routeArgument.selectedCategoryId);
    if (widget.routeArgument.selectedCategoryId != null) {
      print('İF');
      selectedCategories = ['${widget.routeArgument.selectedCategoryId}'];
      await _con.selectCategory(['${widget.routeArgument.selectedCategoryId}']);
    }
    await _con.listenForTrendingProducts(widget.routeArgument.id);
    await _con.listenForCategories(widget.routeArgument.id);
    await _con.listenForCart();
  }

  @override
  void initState() {
    getMarketData();
    super.initState();
  }

  @override
  void dispose() {
    refreshGlobal = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).focusColor.withOpacity(0.3),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0),
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            _con.products.isNotEmpty ? _con.products[0].market.name : '',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: Theme.of(context).textTheme.headline6.merge(
                  TextStyle(
                      color: Color.fromRGBO(255, 228, 121, 1),
                      fontFamily: 'rbt'),
                ),
          ),
          actions: <Widget>[
            _con.loadCart
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.5, vertical: 15),
                    child: SizedBox(
                      width: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : ShoppingCartButtonWidget(
                    fromWhichPage: widget.routeArgument.id,
                    iconColor: Theme.of(context).hintColor,
                    labelColor: Theme.of(context).accentColor),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _con.trendingProducts == null || _con.trendingProducts.length != 0
                  ? ListTile(
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      title: Text(
                        S.of(context).featured_products,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: Text(
                        S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )
                  : Container(),
              _con.trendingProducts == null || _con.trendingProducts.length != 0
                  ? ProductsCarouselWidget(
                      heroTag: 'menu_trending_product',
                      productsList: _con.trendingProducts)
                  : Container(),
              ListTile(
                dense: true,
                contentPadding:
                    EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 0),
                title: Text(
                  S.of(context).products,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.caption,
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
              _con.categories.isEmpty
                  ? SizedBox(height: 45)
                  : Container(
                      height: 45,
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(_con.categories.length, (index) {
                          var _category = _con.categories.elementAt(index);
                          var _selected =
                              selectedCategories.contains(_category.id);
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12),
                            child: RawChip(
                              elevation: 0,
                              label: Text(_category.name),
                              labelStyle: _selected
                                  ? Theme.of(context).textTheme.bodyText2.merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                  : Theme.of(context).textTheme.bodyText2.merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 9),
                              backgroundColor:
                                  Theme.of(context).focusColor.withOpacity(0.1),
                              selectedColor: Theme.of(context).accentColor,
                              selected: _selected,
                              showCheckmark: false,
                              onSelected: (bool value) {
                                setState(() {
                                  localProductList.clear();
                                  if (_category.id == '0') {
                                    selectedCategories = ['0'];
                                  } else {
                                    selectedCategories.removeWhere(
                                        (element) => element == '0');
                                  }
                                  if (value) {
                                    selectedCategories = [];
                                    selectedCategories.add(_category.id);
                                  } else {
                                    selectedCategories.removeWhere(
                                        (element) => element == _category.id);
                                  }
                                  _con.selectCategory(selectedCategories);
                                });
                              },
                            ),
                          );
                        }),
                      ),
                    ),
              _con.products.isEmpty
                  ? Container()
                  : subCategories.isEmpty
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(bottom: 30),
                          height: 32,
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children:
                                List.generate(subCategories.length, (index) {
                              var _subCategory = subCategories.elementAt(index);
                              var _selected1 =
                                  selectedSubCategories.contains(_subCategory);
                              return Padding(
                                padding: EdgeInsetsDirectional.only(start: 12),
                                child: RawChip(
                                  elevation: 0,
                                  label: Text(subCategories.elementAt(index)),
                                  labelStyle: _selected1
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : Theme.of(context).textTheme.bodyText2,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  backgroundColor: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.1),
                                  selectedColor: Colors.green,
                                  selected: _selected1,
                                  showCheckmark: false,
                                  onSelected: (bool value) {
                                    setState(() {
                                      localProductList.clear();
                                      selectedSubCategories.clear();
                                      selectedSubCategories.add(_subCategory);
                                      _con.products.forEach((element) {
                                        if (element.subCategory ==
                                            _subCategory) {
                                          localProductList.add(element);
                                        }
                                      });
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
              _con.products.isEmpty
                  ? CircularLoadingWidget(height: 250)
                  : Offstage(
                      offstage: this.layout != 'list',
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: localProductList.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return ProductItemWidget(
                            heroTag: 'menu_list',
                            product: localProductList.elementAt(index),
                          );
                        },
                      ),
                    ),
              _con.products.isEmpty
                  ? CircularLoadingWidget(height: 250)
                  : Offstage(
                      offstage: this.layout != 'grid',
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 4,
                        children:
                            List.generate(localProductList.length, (index) {
                          return ProductGridItemWidget(
                            onPressed: () async {
                              if (currentUser.value.apiToken == null) {
                                Navigator.of(context).pushNamed('/Login');
                              } else {
                                if (_con.isSameMarkets(
                                    localProductList.elementAt(index))) {
                                  await _con.addToCart(
                                      localProductList.elementAt(index));
                                  await _con.listenForCart();

                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Ürün sepete eklendi.'),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddToCartAlertDialogWidget(
                                          oldProduct:
                                              _con.carts.elementAt(0)?.product,
                                          newProduct:
                                              localProductList.elementAt(index),
                                          onPressed: (product, {reset: true}) {
                                            return _con.addToCart(
                                                localProductList
                                                    .elementAt(index),
                                                reset: true);
                                          });
                                    },
                                  );
                                }
                              }
                            },
                            heroTag: 'favorites_grid',
                            product: localProductList.elementAt(index),
                          );
                        }),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
