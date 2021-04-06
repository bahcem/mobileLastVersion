class RouteArgument {
  String id;
  String marketId;
  String heroTag;
  String fromWhichPage;
  String selectedCategoryId;
  dynamic param;

  RouteArgument(
      {this.id,
      this.selectedCategoryId,
      this.heroTag,
      this.param,
      this.fromWhichPage,
      this.marketId});

  @override
  String toString() {
    return '{id: $id, selectedCategoryId: $selectedCategoryId ,marketId: $marketId,heroTag:${heroTag.toString()}, hangiSayfa:${fromWhichPage.toString()}';
  }
}
