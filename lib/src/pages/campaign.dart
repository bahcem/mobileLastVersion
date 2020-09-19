import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CampaignScreen extends StatefulWidget {
  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends StateMVC<CampaignScreen> {
  HomeController _con;

  _CampaignScreenState() : super(HomeController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).focusColor.withOpacity(0.3),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Kampanyalar',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _con.slides == null
          ? CircularLoadingWidget(
              height: 500,
            )
          : _con.slides.isEmpty
              ? CircularLoadingWidget(
                  height: 500,
                )
              : ListView.builder(
                  itemCount:
                      _con.slides.length == 0 || _con.slides.length == null
                          ? 0
                          : _con.slides.length,
                  itemBuilder: (context, index) {

                    return GestureDetector(
                      onTap: () {
                        if (_con.slides.elementAt(index).product.id != "null") {
                          Navigator.of(context).pushNamed(
                              '/Product',
                              arguments: RouteArgument(
                                  id: _con.slides.elementAt(index).product.id,
                                  heroTag: 'home_slide'));
                        } else {
                          Navigator.of(context).pushNamed(
                              '/Details',
                              arguments: RouteArgument(
                                  id: _con.slides.elementAt(index).market.id,
                                  heroTag: 'home_slide'));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 12,bottom: _con.slides.length == index +1 ? 20 : 0),
                        padding: EdgeInsets.only(left: 10,right: 10, top: 10,bottom:10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    Theme.of(context).focusColor.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                imageUrl: _con.slides.elementAt(index).image.url,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 140,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                             _con.slides.elementAt(index).text == "" ? Container(): SizedBox(
                              height: 10,
                            ),
                            _con.slides.elementAt(index).text == "" ? Container():  Text(
                              "${_con.slides.elementAt(index).button}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Helper.of(context)
                                      .getColorFromHex(_con.slides.elementAt(index).buttonColor),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            _con.slides.elementAt(index).text == "" ? Container():SizedBox(
                              height: 2,
                            ),
                            _con.slides.elementAt(index).text == "" ? Container(): Text(
                              "${_con.slides.elementAt(index).text}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Helper.of(context)
                                      .getColorFromHex(_con.slides.elementAt(index).textColor),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
