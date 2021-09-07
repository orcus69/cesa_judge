import 'dart:convert';
import 'package:cesa_events_judge/models/planilhaControl/planilha.dart';
import 'package:csv/csv.dart';
import 'dart:io';

class PlanilhaControl{

  Future<void> upload(path_file) async{

    final List<Planilha> participants;

    final input = new File(path_file).openRead();
    final csv = await input
      .transform(utf8.decoder)
      .transform(new CsvToListConverter())
      .toList();

    csv.forEach((linha){
      
    });

  }

}