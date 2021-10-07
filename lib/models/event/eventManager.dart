import 'package:cesa_events_judge/models/event/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//Gerenciador de usuário

class EventManager extends ChangeNotifier {


  ///usuario atual
  late Event event;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
  

  Future<void> createEvent({required Event event, required Function onFail, required Function onSuccess}) async {
    loading = true;
    //Id do pedido
    final eventId = await _getEventId();

    try {
      event.id = eventId;
      //Salvando dados do usuário no firebase
      await event.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(print(e.code));
    }
    loading = false;
  }

    //Pegando ID unico de cada pedido
  Future<int> _getEventId() async{
    final ref = firestore.doc('aux/eventCounter');

    //criando transação e retornando ID unico de cada pedido
    try{
      final result = await firestore.runTransaction((transaction) async {
        final doc = await transaction.get(ref);
        final orderId = doc.get('current') as int;

        //atualizando ordercounter no firebase
        await transaction.update(ref, {'current': orderId + 1});

        return {'eventId': orderId};
      }, timeout: const Duration(seconds: 5));

      return result['eventId'] as int;
    }catch(e){
      debugPrint(e.toString());
      return Future.error('Falha ao gerar ID do evento');
    }

    
  }

  Future<int> getEventId() async{
    final ref = firestore.doc('aux/eventCounter');

    //criando transação e retornando ID unico de cada pedido
    try{
      final result = await firestore.runTransaction((transaction) async {
        final doc = await transaction.get(ref);
        final orderId = doc.get('current') as int;

        return {'eventId': orderId};
      }, timeout: const Duration(seconds: 5));

      return result['eventId'] as int;
    }catch(e){
      debugPrint(e.toString());
      return Future.error('Falha ao obter ID do evento');
    }
  }

  //Verifica se o codigo do evento existe no firestore
  static Future<bool?> validateQrCode(String arg)async {
    final ref = await FirebaseFirestore.instance.doc('events/$arg')
    .get().then(
      (value) {
        if(value.exists)
          return true;
        return false;
      }
    );

    return ref;
    
  }

}
