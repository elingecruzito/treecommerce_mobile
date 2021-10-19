import 'package:shared_preferences/shared_preferences.dart';
import 'package:treecommerce/src/model/user_model.dart';

class UserPreferences{

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences(){
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

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

  setCount(int _count){
    _prefs.setInt("count", _count);
  }

  get count{
    return _prefs.getInt("count");
  }

  destroy(){
    _prefs.clear();
  }


}