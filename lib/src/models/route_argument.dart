class RouteArgument {
  String id;
  String heroTag;
  String fromWhichPage;
  dynamic param;

  RouteArgument({this.id, this.heroTag, this.param, this.fromWhichPage});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}, hangiSayfa:${fromWhichPage.toString()}';
  }
}
