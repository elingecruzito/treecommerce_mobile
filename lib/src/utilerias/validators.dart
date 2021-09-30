import 'dart:async';

class Validators{
  final isEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError("Email no es valido");
      }
    }
  );
  
  final isEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (txt, sink){
      if( !txt.isEmpty ){
        sink.add(txt);
      }else{
        sink.addError("El valor no debe de estar vacio!");
      }
    }
  );
}