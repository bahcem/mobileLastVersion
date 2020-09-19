import 'package:flutter/material.dart';
import '../elements/HomeSliderWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: new IconButton(
//          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
//          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
//        ),
        actions: [
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: GestureDetector(
              onTap: () {
                if (currentUser.value.apiToken == null) {
                  _con.requestForCurrentLocation(context);
                } else {
                  var bottomSheetController =
                      widget.parentScaffoldKey.currentState.showBottomSheet(
                    (context) => DeliveryAddressBottomSheetWidget(
                        scaffoldKey: widget.parentScaffoldKey),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                  );
                  bottomSheetController.closed.then((value) {
                    _con.refreshHome();
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.only(left: 10, right: 6),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 2)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  border: Border.all(
                      color: Theme.of(context).accentColor,
                      width: 1.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(fontWeight: FontWeight.w900)),
                          text: settingsRepo.deliveryAddress.value.description ==
                                  null
                              ? ""
                              : settingsRepo.deliveryAddress.value.description ==
                                      ""
                                  ? ""
                                  : settingsRepo.deliveryAddress.value.description
                                              .length <
                                          2
                                      ? "${settingsRepo.deliveryAddress.value.description}" +
                                          " - "
                                      : ("${settingsRepo.deliveryAddress.value?.description.toString().substring(0, 2)}" +
                                          " - "),
                          children: <TextSpan>[
                            TextSpan(
                              style: Theme.of(context).textTheme.bodyText2,
                              text: settingsRepo.deliveryAddress.value?.address ==
                                      null
                                  ? "Adres Seçin"
                                  : (settingsRepo.deliveryAddress.value?.address
                                          .toString()
                                          .substring(0, 15) ??
                                      "Adres Seçin"),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 22,
                          color: Theme.of(context).accentColor,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: ValueListenableBuilder(
          valueListenable: settingsRepo.setting,
          builder: (context, value, child) {
            return Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(
                value.appName ?? S.of(context).home,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .merge(TextStyle(letterSpacing: 1.3,fontFamily: 'Yellowtail',fontSize: 32,fontWeight: FontWeight.w200,color: Theme.of(context).accentColor.withOpacity(1))),
              ),
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(
                  onClickFilter: (event) {
                    widget.parentScaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ),
              HomeSliderWidget(slides: _con.slides),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(top: 10),
                  // leading: Icon(
                  //                    Icons.stars,
                  //                    color: Theme.of(context).hintColor,
                  //                  ),

                  title: Text(
                    S.of(context).top_markets,
                    style: Theme.of(context).textTheme.headline4,
                  ),

                ),
              ),
              //Text(
              //                            (settingsRepo.deliveryAddress.value?.description ??
              //                                "" ),
              //                            style: TextStyle(
              //                                fontSize: 14.0,
              //                                fontWeight: FontWeight.w600,
              //                                color: Theme.of(context).focusColor,
              //                                height: 1.2),
              //                          ),
              //                          Text(
              //                            (settingsRepo.deliveryAddress.value?.address ??
              //                                S.of(context).unknown),
              //                            style: TextStyle(
              //                                fontSize: 14.0,
              //                                fontWeight: FontWeight.w300,
              //                                color: Theme.of(context).focusColor,
              //                                height: 1.2),
              //                          ),
              CardsCarouselWidget(
                  marketsList: _con.topMarkets, heroTag: 'home_top_markets'),

          //Padding(
              //                padding: const EdgeInsets.symmetric(horizontal: 20),
              //                child: ListTile(
              //                  dense: true,
              //                  contentPadding: EdgeInsets.symmetric(vertical: 0),
              //                  //leading: Icon(
              //                  //                    Icons.category,
              //                  //                    color: Theme.of(context).hintColor,
              //                  //                  ),
              //                  title: Text(
              //                    S.of(context).product_categories,
              //                    style: Theme.of(context).textTheme.headline4,
              //                  ),
              //                ),
              //              ),

              //CategoriesCarouselWidget(
                //categories: _con.categories,
              //),
              _con.trendingProducts == null
                  ? ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                //leading: Icon(
                //                  Icons.trending_up,
                //                  color: Theme.of(context).hintColor,
                //                ),
                title: Text(
                  S.of(context).trending_this_week,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.caption,
                ),
              )
                  : _con.trendingProducts.isEmpty
                  ? Container()
                  : ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                //leading: Icon(
                //                  Icons.trending_up,
                //                  color: Theme.of(context).hintColor,
                //                ),
                title: Text(
                  S.of(context).trending_this_week,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  S
                      .of(context)
                      .clickOnTheProductToGetMoreDetailsAboutIt,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              _con.trendingProducts == null
                  ? ProductsCarouselWidget(
                productsList: _con.trendingProducts,
                heroTag: 'home_products_carousel',
              )
                  : _con.trendingProducts.isEmpty
                  ? Container()
                  : ProductsCarouselWidget(
                  productsList: _con.trendingProducts,
                  heroTag: 'home_product_carousel'),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  //leading: Icon(
                  //                    Icons.trending_up,
                  //                    color: Theme.of(context).hintColor,
                  //                  ),
                  title: Text(
                    S.of(context).most_popular,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridWidget(
                  marketsList: _con.popularMarkets,
                  heroTag: 'home_markets',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  //leading: Icon(
                  //                    Icons.recent_actors,
                  //                    color: Theme.of(context).hintColor,
                  //                  ),
                  title: Text(
                    S.of(context).recent_reviews,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ReviewsListWidget(reviewsList: _con.recentReviews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
