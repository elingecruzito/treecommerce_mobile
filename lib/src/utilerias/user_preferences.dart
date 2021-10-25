import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/model/productos_model.dart';
import 'package:treecommerce/src/model/user_model.dart';

class UserPreferences{

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences(){
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  List<ProductosModel> _list_productos;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();  
  }

  userModel(UserModel _userModel){
    _prefs.setInt("id", _userModel.id);
    _prefs.setString("name", _userModel.name);
    _prefs.setString("email", _userModel.email);
    _prefs.setString("rememberToken", _userModel.rememberToken);
  }

  get id{
    return _prefs.getInt("id");
  }

  get name{
    return _prefs.getString("name");
  }

  get email{
    return _prefs.getString("email");
  }

  get token{
    return _prefs.getString("rememberToken");
  }

  bool userExist(){
    return _prefs.getKeys().isEmpty;
  }


//---------------------Stock--------------------------------

  setCount(int _count){
    _prefs.setInt("count", _count);
  }

  get count{
    return _prefs.getInt("count");
  }
  
//----------------------------------------------------------

  // setListProducts(ProductosModel _producto){
  //   if( _list_productos == null){
  //     _list_productos = new List<ProductosModel>();
  //   }
  //   _list_productos.add(_producto);
  //   _prefs.setStringList('products', productosListModelToJson(_list_productos));
  // }

  // get listProducts{
  //   return productosListModelFromJson(_prefs.getStringList('products').toString());
  // }

  destroy(){
    _prefs.clear();
  }


}