import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/menu_list.dart';
import '../pages/product.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return widget.slides == null
        ? HomeSliderLoaderWidget()
        : widget.slides.isEmpty
            ? HomeSliderLoaderWidget()
            : Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      height: 190,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    items: widget.slides.map((Slide slide) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 0),
                            height: 170,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.15),
                                    blurRadius: 15,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (slide.product.id != "null") {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ProductWidget(
                                              routeArgument: RouteArgument(
                                                  id: slide.product.id,
                                                  heroTag: 'home_slide'),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => MenuWidget(
                                              routeArgument: RouteArgument(
                                                  id: slide.market.id,
                                                  heroTag: 'home_slide'),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      height: 170,
                                      width: double.infinity,
                                      fit: Helper.getBoxFit(slide.imageFit),
                                      imageUrl: slide.image.url,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/img/loading.gif',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 170,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 12,
                    margin: EdgeInsets.only(bottom: 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: widget.slides.map((Slide slide) {
                          return Container(
                            width: 20.0,
                            height: 3.0,
                            margin: EdgeInsets.only(left: 2.0, right: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: _current == widget.slides.indexOf(slide)
                                    ? Helper.of(context)
                                        .getColorFromHex(slide.indicatorColor)
                                    : Helper.of(context)
                                        .getColorFromHex(slide.indicatorColor)
                                        .withOpacity(0.3)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
  }
}
