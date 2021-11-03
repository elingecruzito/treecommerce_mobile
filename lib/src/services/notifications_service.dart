import 'package:treecommerce/src/model/notifications_model.dart';
import 'package:treecommerce/src/services/services.dart';
import 'package:treecommerce/src/utilerias/directions.dart';
import 'package:treecommerce/src/utilerias/user_preferences.dart';

class NotificationsService{

  Future<List<NotificationsModel>> getNotifications(UserPreferences _preferences) async{
    return await petition(
      Directions().path_notifications_list,{
      'token' : _preferences.token,
    }).then((value) {
      if(value.code == 200)
        return notificationsListModelFromJson(value.body);
      return null;
    });
  }

}