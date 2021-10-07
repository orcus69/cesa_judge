import 'package:cesa_events_judge/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//Gerenciador de usuário

class UserManager extends ChangeNotifier {


  ///usuario atual
  late User user;

  bool _loading = false;
  bool get loading => _loading;
  
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingfb = false;
  bool get loadingfb => _loadingfb;
  
  set loadingfb(bool value) {
    _loadingfb = value;
    notifyListeners();
  }

  //verifica se está logado
  bool get isLoggedIn => user != null;

  Future<void> signUp({required User user, required Function onFail, required Function onSuccess}) async {
    loading = true;
    try {
      //Salvando dados do usuário no firebase
      await user.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(print(e.code));
    }
    loading = false;
  }

}
