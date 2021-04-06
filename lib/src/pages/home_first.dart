import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../pages/pages.dart';
import '../controllers/filter_controller.dart';
import '../pages/global.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeFirstWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  const HomeFirstWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeFirstWidgetState createState() => _HomeFirstWidgetState();
}

class _HomeFirstWidgetState extends StateMVC<HomeFirstWidget> {
  FilterController _con;
  TextEditingController controllerText = TextEditingController();

  _HomeFirstWidgetState() : super(FilterController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
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
      body: ListView.builder(
        itemCount: _con.fields.length == null || _con.fields.length == 0
            ? 5
            : _con.fields.length,
        itemBuilder: (context, index) {
          if (controllerText == null || controllerText == '') {
            return Column(
              children: [
                SizedBox(
                  height: index == 0 ? 6 : 0,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _con.filter.open = false;
                    _con.filter.delivery = true;

                    await _con.onChangeFieldsFilter(index);
                    await _con.saveFilter().then((value) {
                      filterGlobal = _con.filter;
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => PagesWidget(
                                  currentTab: 0,
                                ),
                            fullscreenDialog: true),
                      );
                    });
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                    width: MediaQuery.of(context).size.width - 32,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromRGBO(225, 225, 225, 1),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _con.fields.length == 0
                            ? ''
                            : _con.fields.elementAt(index).image.toString(),
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            if (_con.fields.length == 0 || _con.fields == null) {
              return Column(
                children: [
                  SizedBox(
                    height: index == 0 ? 6 : 0,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 6, bottom: 6),
                      width: MediaQuery.of(context).size.width - 32,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '',
                          height: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              if (_con.fields
                  .elementAt(index)
                  .name
                  .toString()
                  .toLowerCase()
                  .contains(controllerText.text.toString().toLowerCase())) {
                return Column(
                  children: [
                    SizedBox(
                      height: index == 0 ? 6 : 0,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _con.filter.open = false;
                        _con.filter.delivery = true;

                        await _con.onChangeFieldsFilter(index);
                        await _con.saveFilter().then((value) {
                          filterGlobal = _con.filter;
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => PagesWidget(
                                      currentTab: 0,
                                    ),
                                fullscreenDialog: true),
                          );
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 6, bottom: 6),
                        width: MediaQuery.of(context).size.width - 32,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(225, 225, 225, 1),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: _con.fields.length == 0
                                ? ''
                                : _con.fields.elementAt(index).image.toString(),
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }
          }
        },
      ),
    );
  }
}
