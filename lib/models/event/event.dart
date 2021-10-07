import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Event extends ChangeNotifier{


  int?      id;
  String?   title;
  String?   description;
  String?   date;
  int?      juizes;
  String?   linkSheet;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  DocumentReference get firestoreRef =>
    firestore.doc('events/CSA000${id}');

  //Acessa referencia do usuário no firestore
  //Seta dados do usuário
  Future<void> saveData() async{
    await firestoreRef.set(toMap());
  }

  //Dados do usuário
  Map<String, dynamic> toMap(){
    return {
      'title'       : title,
      'description' : description,
      'date'        : date,
      'juizes'      : juizes,
      'link'        : linkSheet,
    };
  }

}