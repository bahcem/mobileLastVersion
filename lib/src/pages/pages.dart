import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../controllers/filter_controller.dart';
import '../pages/search_for_home.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../pages/cart.dart';
import '../pages/settings.dart';
import '../models/route_argument.dart';
import '../pages/home.dart';
import 'global.dart';
import 'home_first.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = HomeFirstWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({Key key, this.currentTab}) {

    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        currentTab = int.parse(currentTab.id);
      }
    } else {

      currentTab = 2;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends StateMVC<PagesWidget> {
  FilterController _con;

  _PagesWidgetState() : super(FilterController()) {
    _con = controller;
  }

  HomeWidget myHome = HomeWidget();

  final home = GlobalKey<NavigatorState>();
  final search = GlobalKey<NavigatorState>();
  final cart = GlobalKey<NavigatorState>();
  final profile = GlobalKey<NavigatorState>();

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab, false);

    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem, bool value) {

    if (widget.currentTab == tabItem) {

      setState(() {
        switch (tabItem) {
          case 0:
            if (home.currentState.canPop()) {

              home.currentState.popUntil((route) => route.isFirst);
            } else {
              if (value == false) {

              } else {

                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => HomeFirstWidget(),
                      fullscreenDialog: true),
                );
              }
            }
            break;
          case 1:
            search.currentState.popUntil((route) => route.isFirst);
            break;
          case 2:
            cart.currentState.popUntil((route) => route.isFirst);
            break;
          case 3:
            profile.currentState.popUntil((route) => route.isFirst);
            break;
        }
      });
    } else {
      if (mounted) {
        setState(() {

          widget.currentTab = tabItem;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        switch (widget.currentTab) {
          case 0:
            home.currentState.maybePop();
            break;
          case 1:
            search.currentState.maybePop();
            break;
          case 2:
            cart.currentState.maybePop();
            break;
          case 3:
            profile.currentState.maybePop();
            break;
          default:
        }
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 46),
          child: FloatingActionButton(
            elevation: 0,
            mini: true,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //   Text(
                          //                                   'Kategoriler',
                          //                                   style: TextStyle(
                          //                                       color: Colors.white, fontSize: 32),
                          //                                 ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 350,
                            child: GridView.count(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 24,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              crossAxisCount: 2,
                              childAspectRatio: 16 / 9,
                              children: List.generate(_con.fields.length, (index) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        refreshGlobal = true;
                                      });
                                      await _con.clearFilter();
                                      _con.filter.open = false;
                                      _con.filter.delivery = true;
                                      await _con.onChangeFieldsFilter(index);
                                      setState(() {
                                        filterGlobal = _con.filter;
                                      });
                                      await _con
                                          .saveFilter()
                                          .then((value) async {
                                        HomeController().refreshSpecial();
                                        _selectTab(0, false);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                225, 225, 225, 1),
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          )),
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: _con.fields
                                              .elementAt(index)
                                              .image
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Icon(Icons.crop_square, size: 26, color: Colors.white),
            ),
          ),
        ),
        key: widget.scaffoldKey,
        body: IndexedStack(
          index: widget.currentTab,
          children: [
            _con.fields == null || _con.fields.length == 0
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(54, 54, 54, 1),
                        ),
                      ),
                    ),
                  )
                : Navigator(
                    key: home,
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(
                          settings: settings,
                          builder: (BuildContext context) {
                            return HomeWidget(
                              parentScaffoldKey: widget.scaffoldKey,
                            );
                          });
                    },
                  ),
            Navigator(
              key: search,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                    settings: settings,
                    builder: (BuildContext context) {
                      return SearchHomeWidget();
                    });
              },
            ),
            Navigator(
              key: cart,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                    settings: settings,
                    builder: (BuildContext context) {
                      return CartWidget();
                    });
              },
            ),
            Navigator(
              key: profile,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                    settings: settings,
                    builder: (BuildContext context) {
                      return SettingsWidget();
                    });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 30,
          backgroundColor: Theme.of(context).primaryColor,
          //selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i, true);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // ignore: deprecated_member_use
              title: Text(
                "Anasayfa",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 11),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 24),
                child: Icon(
                  Icons.search,
                  size: 26,
                ),
              ),
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
                  "Arama",
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 11),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 24),
                child: Icon(
                  Icons.shopping_basket,
                  size: 26,
                ),
              ),
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  "Sepetim",
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 11),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.person,
                size: 26,
              ),
              // ignore: deprecated_member_use
              title: Text(
                "Hesabım",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
