import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../pages/menu_list.dart';
import '../models/category.dart';

// ignore: must_be_immutable
class CategoryGridlItemWidget extends StatefulWidget {
  Category category;
  String marketId;

  CategoryGridlItemWidget({Key key, this.category, this.marketId})
      : super(key: key);

  @override
  _CategoryGridlItemWidgetState createState() =>
      _CategoryGridlItemWidgetState();
}

class _CategoryGridlItemWidgetState extends State<CategoryGridlItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MenuWidget(
              routeArgument: RouteArgument(
                  id: widget.marketId, selectedCategoryId: widget.category.id),
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: ((MediaQuery.of(context).size.width - 40) / 3),
              width: (MediaQuery.of(context).size.width - 40) / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.category.image.thumb),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              height: 50,
              color: Colors.white,
              width: (MediaQuery.of(context).size.width - 40) / 3,
              child: Text(
                widget.category.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
