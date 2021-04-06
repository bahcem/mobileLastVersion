import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../repository/cart_repository.dart';
import '../pages/global.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../models/category.dart';
import '../models/gallery.dart';
import '../models/market.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../repository/category_repository.dart';
import '../repository/gallery_repository.dart';
import '../repository/market_repository.dart';
import '../repository/product_repository.dart';
import '../repository/settings_repository.dart';

class MarketController extends ControllerMVC {
  Market market;
  List<Gallery> galleries = <Gallery>[];
  List<Product> products = <Product>[];
  List<Category> categories = <Category>[];
  List<Product> trendingProducts = <Product>[];
  List<Product> featuredProducts = <Product>[];
  List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Cart> carts = [];
  List<Product> fakeList = <Product>[];
  bool loadCart = false;
  double quantity = 1;

  MarketController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForMarket({String id, String message}) async {
    final Stream<Market> stream = await getMarket(id, deliveryAddress.value);
    stream.listen((Market _market) {
      setState(() => market = _market);
    }, onError: (a) {
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForGalleries(String idMarket) async {
    final Stream<Gallery> stream = await getGalleries(idMarket);
    stream.listen((Gallery _gallery) {
      setState(() => galleries.add(_gallery));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForMarketReviews({String id, String message}) async {
    final Stream<Review> stream = await getMarketReviews(id);
    stream.listen((Review _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForCart() async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      carts.add(_cart);
    });
  }

  bool isSameMarkets(Product product) {
    if (carts.isNotEmpty) {
      return carts[0].product?.market?.id == product.market?.id;
    }
    return true;
  }

  void addToCart(Product product, {bool reset = false}) async {
    print(product.toMap());
    setState(() {
      this.loadCart = true;
    });
    var _newCart = new Cart();
    _newCart.product = product;
    _newCart.options =
        product.options.where((element) => element.checked).toList();
    _newCart.quantity = this.quantity;
    print(_newCart.toMap());
    print(
        '////////////////////////////////////////////////////////////////////////////////');
    var _oldCart = isExistInCart(_newCart);
    if (_oldCart != null) {
      _oldCart.quantity += this.quantity;
      updateCart(_oldCart).then((value) {
        print(value.toMap());
        setState(() {
          this.loadCart = false;
        });
      });
    } else {
      addCart(_newCart, reset).then((value) {
        setState(() {
          this.loadCart = false;
        });
      }).whenComplete(() {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_product_was_added_to_cart),
        ));
      });
    }
  }

  Cart isExistInCart(Cart _cart) {
    print(_cart);
    print(carts);
    return carts.firstWhere((Cart oldCart) => _cart.isSame(oldCart),
        orElse: () => null);
  }

  void listenForProducts(String idMarket, {List<String> categoriesId}) async {
    final Stream<Product> stream =
        await getProductsOfMarket(idMarket, categories: categoriesId);
    stream.listen(
        (Product _product) {
          setState(() {
            products.add(_product);
          });
        },
        onError: (a) {},
        onDone: () {
          subCategories = [];
          products.forEach((element) {
            subCategories.add(element.subCategory);
            subCategories = LinkedHashSet<String>.from(subCategories).toList();
          });
          selectedSubCategories = ['${subCategories.first}'];
          products.forEach((element) {
            if (subCategories.first == element.subCategory) {
              localProductList.add(element);
            }
          });
          market..name = products?.elementAt(0)?.market?.name;
        });
  }

  void listenForTrendingProducts(String idMarket) async {
    final Stream<Product> stream = await getTrendingProductsOfMarket(idMarket);
    stream.listen((Product _product) {
      print(_product);
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForFeaturedProducts(String idMarket) async {
    final Stream<Product> stream = await getFeaturedProductsOfMarket(idMarket);
    stream.listen((Product _product) {
      setState(() => featuredProducts.add(_product));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForCategories(String marketId) async {
    final Stream<Category> stream = await getCategoriesOfMarket(marketId);
    stream.listen(
        (Category _category) {
          setState(() {
            categories.add(_category);
          });
        },
        onError: (a) {},
        onDone: () {
          print('onDONE');
          selectedCategories = [];
          if (selectedCategories.isEmpty) {
            selectCategory(['${categories[0].id.toString()}']);
            selectedCategories = ['${categories[0].id}'];
          } else {
            print('ELSE');
          }
        });
  }

  Future<void> selectCategory(List<String> categoriesId) async {
    products.clear();
    listenForProducts(market.id, categoriesId: categoriesId);
  }

  Future<void> refreshMarket() async {
    var _id = market.id;
    market = new Market();
    galleries.clear();
    reviews.clear();
    featuredProducts.clear();
    listenForMarket(
        id: _id, message: S.of(context).market_refreshed_successfuly);
    listenForMarketReviews(id: _id);
    listenForGalleries(_id);
    listenForFeaturedProducts(_id);
  }
}
