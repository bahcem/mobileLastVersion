import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final User user;
  ProfileAvatarWidget({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
//              SizedBox(
//                width: 50,
//                height: 50,
//                child: FlatButton(
//                  padding: EdgeInsets.all(0),
//                  onPressed: () {},
//                  child: Icon(Icons.add, color: Theme.of(context).primaryColor),
//                  color: Theme.of(context).accentColor,
//                  shape: StadiumBorder(),
//                ),
//              ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  child: CachedNetworkImage(
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                    imageUrl: user.image?.url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
//              SizedBox(
//                width: 50,
//                height: 50,
//                child: FlatButton(
//                  padding: EdgeInsets.all(0),
//                  onPressed: () {},
//                  child: Icon(Icons.chat, color: Theme.of(context).primaryColor),
//                  color: Theme.of(context).accentColor,
//                  shape: StadiumBorder(),
//                ),
//              ),
              ],
            ),
          ),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headline5.merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
//          Padding(
//            padding: EdgeInsets.only(left: 20,right: 20),
//            child: Text(
//              user.address,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//              style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
//            ),
//          ),
        ],
      ),
    );
  }
}
