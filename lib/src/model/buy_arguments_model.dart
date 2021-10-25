import 'package:treecommerce/src/model/directions_model.dart';
import 'package:treecommerce/src/model/productos_model.dart';

class BuyArguments {
  final ProductosModel product;
  final DirectionsModel direction;

  BuyArguments(this.product, this.direction);
}