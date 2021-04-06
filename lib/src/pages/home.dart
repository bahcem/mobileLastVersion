import 'package:flutter/material.dart';
import '../elements/HomeSliderWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';
import 'all_markets.dart';

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
  void didUpdateWidget(covariant StatefulWidget oldWidget) {

    _con.refreshSpecial();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
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
                      color: Theme.of(context).accentColor, width: 1.2),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(TextStyle(fontWeight: FontWeight.w900)),
                          text: settingsRepo
                                      .deliveryAddress.value.description ==
                                  null
                              ? ""
                              : settingsRepo
                                          .deliveryAddress.value.description ==
                                      ""
                                  ? ""
                                  : settingsRepo.deliveryAddress.value
                                              .description.length <
                                          2
                                      ? "${settingsRepo.deliveryAddress.value.description}" +
                                          " - "
                                      : ("${settingsRepo.deliveryAddress.value?.description.toString().substring(0, 2)}" +
                                          " - "),
                          children: <TextSpan>[
                            TextSpan(
                              style: Theme.of(context).textTheme.bodyText2,
                              text: settingsRepo
                                          .deliveryAddress.value?.address ==
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
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: false,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 228, 121, 1)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/img/bk.png',
                  width: 32,
                  height: 32,
                )),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              HomeSliderWidget(slides: _con.slides),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 12),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(top: 10),
                  // leading: Icon(
                  //                    Icons.stars,
                  //                    color: Theme.of(context).hintColor,
                  //                  ),

                  title: Text(
                    S.of(context).top_markets,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .merge(TextStyle(fontSize: 18)),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllMarketsScreen(
                            marketList: _con.topMarkets,
                            heroTag: 'home_top_markets',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, right: 10, left: 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.12),
                                blurRadius: 10,
                                offset: Offset(0, 2)),
                          ],
                          color: Theme.of(context).accentColor,
                          border: Border.all(
                            color: Theme.of(context).accentColor,
                          ),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "Tüm Mağazalar",
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              CardsCarouselWidget(
                  marketsList: _con.topMarkets, heroTag: 'home_top_markets'),
            ],
          ),
        ),
      ),
    );
  }
}
