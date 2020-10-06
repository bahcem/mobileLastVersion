import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/CardWidget.dart';
import '../../generated/l10n.dart';



class AllMarketsScreen extends StatefulWidget {
  final String heroTag;
  final data;

  const AllMarketsScreen({Key key, this.data,this.heroTag}) : super(key: key);

  @override
  _AllMarketsScreenState createState() => _AllMarketsScreenState();
}

class _AllMarketsScreenState extends State<AllMarketsScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.data == null ? CircularLoadingWidget(height: 500,) : Scaffold(
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
          'Tüm Marketler',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Details',
                  arguments: RouteArgument(
                    id: widget.data.elementAt(index).id,
                    heroTag: widget.heroTag,
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(top: index == 0 ? 10 : 0),
              padding: EdgeInsets.only(right:20),
              child: CardWidget(market: widget.data.elementAt(index), heroTag: widget.heroTag),
            ),
          );
        },
      ),
    );
  }
}
