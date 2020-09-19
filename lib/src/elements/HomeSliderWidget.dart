import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/app_config.dart' as config;
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
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    return widget.slides == null
        ? HomeSliderLoaderWidget()
        : widget.slides.isEmpty
            ? HomeSliderLoaderWidget()
            : Stack(
                alignment: _alignmentDirectional ??
                    Helper.getAlignmentDirectional(
                        widget.slides.elementAt(0).textPosition),
                fit: StackFit.passthrough,
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      height: 160,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                          _alignmentDirectional =
                              Helper.getAlignmentDirectional(
                                  widget.slides.elementAt(index).textPosition);
                        });
                      },
                    ),
                    items: widget.slides.map((Slide slide) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 0),
                            height: 140,
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
                                        Navigator.of(context).pushNamed(
                                            '/Product',
                                            arguments: RouteArgument(
                                                id: slide.product.id,
                                                heroTag: 'home_slide'));
                                      } else {
                                        Navigator.of(context).pushNamed(
                                            '/Details',
                                            arguments: RouteArgument(
                                                id: slide.market.id,
                                                heroTag: 'home_slide'));
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      height: 140,
                                      width: double.infinity,
                                      fit: Helper.getBoxFit(slide.imageFit),
                                      imageUrl: slide.image.url,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/img/loading.gif',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 140,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                               // Container(
                                //                                  alignment: Helper.getAlignmentDirectional(
                                //                                      slide.textPosition),
                                //                                  width: double.infinity,
                                //                                  padding: const EdgeInsets.symmetric(
                                //                                      horizontal: 20),
                                //                                  child: Container(
                                //                                    width: config.App(context).appWidth(40),
                                //                                    child: Column(
                                //                                      crossAxisAlignment:
                                //                                          CrossAxisAlignment.stretch,
                                //                                      mainAxisSize: MainAxisSize.max,
                                //                                      mainAxisAlignment:
                                //                                          MainAxisAlignment.center,
                                //                                      children: <Widget>[
                                //                                        if (slide.text != null &&
                                //                                            slide.text != '')
                                //                                          Text(
                                //                                            slide.text,
                                //                                            style: Theme.of(context)
                                //                                                .textTheme
                                //                                                .headline6
                                //                                                .merge(
                                //                                                  TextStyle(
                                //                                                    fontSize: 14,
                                //                                                    height: 1,
                                //                                                    color: Helper.of(context)
                                //                                                        .getColorFromHex(
                                //                                                            slide.textColor),
                                //                                                  ),
                                //                                                ),
                                //                                            textAlign: TextAlign.center,
                                //                                            overflow: TextOverflow.fade,
                                //                                            maxLines: 3,
                                //                                          ),
                                //                                        if (slide.button != null &&
                                //                                            slide.button != '')
                                //                                          FlatButton(
                                //                                            onPressed: () {
                                //                                              if (slide.product.id != "null") {
                                //                                                Navigator.of(context).pushNamed(
                                //                                                    '/Product',
                                //                                                    arguments: RouteArgument(
                                //                                                        id: slide.product.id,
                                //                                                        heroTag: 'home_slide'));
                                //                                              } else {
                                //                                                Navigator.of(context).pushNamed(
                                //                                                    '/Details',
                                //                                                    arguments: RouteArgument(
                                //                                                        id: slide.market.id,
                                //                                                        heroTag: 'home_slide'));
                                //                                              }
                                //                                            },
                                //                                            padding: EdgeInsets.symmetric(
                                //                                                vertical: 5),
                                //                                            color: Helper.of(context)
                                //                                                .getColorFromHex(
                                //                                                    slide.buttonColor),
                                //                                            shape: StadiumBorder(),
                                //                                            child: Text(
                                //                                              slide.button,
                                //                                              textAlign: TextAlign.start,
                                //                                              style: TextStyle(
                                //                                                  color: Theme.of(context)
                                //                                                      .primaryColor),
                                //                                            ),
                                //                                          ),
                                //                                      ],
                                //                                    ),
                                //                                  ),
                                //                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.slides.map((Slide slide) {
                        return Container(
                          width: 20.0,
                          height: 3.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 2.0),
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
                ],
              );
  }
}
