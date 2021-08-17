import 'dart:async';

class Validators{
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