import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/CardWidget.dart';
import 'menu_list.dart';

class AllMarketsScreen extends StatefulWidget {
  final String heroTag;
  final List marketList;

  const AllMarketsScreen({Key key, this.marketList, this.heroTag})
      : super(key: key);

  @override
  _AllMarketsScreenState createState() => _AllMarketsScreenState();
}

class _AllMarketsScreenState extends State<AllMarketsScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.marketList == null
        ? CircularLoadingWidget(
            height: 500,
          )
        : Scaffold(
            appBar: AppBar(
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
                'Tüm Marketler',
                style: TextStyle(
                    color: Color.fromRGBO(255, 228, 121, 1), fontFamily: 'rbt'),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).primaryColor,
              ),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.marketList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MenuWidget(
                          routeArgument: RouteArgument(
                            id: widget.marketList.elementAt(index).id,
                            heroTag: widget.heroTag,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(top: index == 0 ? 10 : 0, right: 20),
                    child: CardWidget(
                        market: widget.marketList.elementAt(index),
                        heroTag: widget.heroTag),
                  ),
                );
              },
            ),
          );
  }
}
