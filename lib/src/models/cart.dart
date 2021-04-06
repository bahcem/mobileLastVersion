import '../models/market.dart';
import '../models/option.dart';
import '../models/product.dart';

class Cart {
  String id;
  Product product;
  double quantity;
  List<Option> options;
  String userId;
  Market market;

  Cart();

  Cart.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      quantity =
          jsonMap['quantity'] != null ? jsonMap['quantity'].toDouble() : 0.0;
      product = jsonMap['product'] != null
          ? Product.fromJSON(jsonMap['product'])
          : Product.fromJSON({});
      options = jsonMap['options'] != null
          ? List.from(jsonMap['options'])
              .map((element) => Option.fromJSON(element))
              .toList()
          : [];
      market = jsonMap['product']['market'] != null
          ? Market.fromJSON(jsonMap['product']['market'])
          : Market.fromJSON({});
    } catch (e) {
      id = '';
      quantity = 0.0;
      product = Product.fromJSON({});
      options = [];
      market = Market.fromJSON({});
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["quantity"] = quantity;
    map["product_id"] = product.id;
    map["user_id"] = userId;
    map["options"] = options.map((element) => element.id).toList();
    return map;
  }

  double getProductPrice() {
    double result = product.price;
    if (options.isNotEmpty) {
      options.forEach((Option option) {
        result += option.price != null ? option.price : 0;
      });
    }
    return result;
  }

  bool isSame(Cart cart) {
    print(cart);
    bool _same = true;
    _same &= this.product == cart.product;
    print(cart.product.toMap());
    print(_same);
    _same &= this.options.length == cart.options.length;
    if (_same) {
      this.options.forEach((Option _option) {
        _same &= cart.options.contains(_option);
      });
    }

    return _same;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
