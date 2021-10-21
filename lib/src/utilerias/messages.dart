class Messages{

  final int CODE_OK = 200; //La solicitud ha tenido éxito
  final int CODE_CREATED = 201; //La solicitud ha tenido éxito y se ha creado un nuevo recurso como resultado de ello
  final int CODE_BAD_REQUEST = 400; // No pudo interpretar la solicitud dada una sintaxis inválida
  final int CODE_NOT_FOUND = 404; // El servidor no pudo encontrar el contenido solicitado
  final int CODE_INTERNAL_SERVER_ERROR = 500; //El servidor ha encontrado una situación que no sabe cómo manejarla

//---------------------------------------------------------------------------------------------------

  final String TITLE_ERROR = "Error!";

  final String LOGIN_ERROR_HASDATA = "Alguno de los datos es incorrecto!";
  final String LOGIN_ERROR_AUTHENTIFICATE = "Usuario no encontrado!";

//----------------------------------------------------------------------------------------------

  final String TITLE_ALERT_LOGOUT = "Logout";
  final String MESSAGE_ALERT_LOGOUT = "Quieres salir de tu cuenta?";

//----------------------------------------------------------------------------------------------

  final String MESSAGE_ALERT_COUNT = 'Cantidad incorrecta!';

//----------------------------------------------------------------------------------------------

  final String DIRECTIONS_ERROR_SELECTED = 'Debes seleccionar una direccion.';

}