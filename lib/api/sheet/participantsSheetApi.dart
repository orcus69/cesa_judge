import 'package:cesa_events_judge/models/participants/participants.dart';
import 'package:gsheets/gsheets.dart';

class ParticipantsSheetApi{

  List<String> header = [];

  static const _credentials = r'''
    {
      "type": "service_account",
      "project_id": "cesaevents",
      "private_key_id": "ddc2c963e2303494a4f8aa5e4c2c15d89e329626",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDkKxxWjqZ9pIh3\no7BVIsWjublPVv7ADY7UXhhfze3WorS2gpzRGxGEP2cuFEQkW9jI/CUx8g3M2hEB\nwiNIEzd3fmIwxfG31nnVt9Ak2NZrrNQGGtMF+OAW4qg79OKO6McSPixlaQLsr0HC\nToZ+eB24lqNvdC14i3LJ3X9mq2jWj0m41mgFyyWpGy2kv6H2yS487TMchUcjrLXh\noQyI0GzCHIJ6OhwFlHdCK6LQ2bbeSaFWMVB7snUz72vJB3Ssb1RfQ+w77t5nmxtL\nSIyY5EdD+fK4ESOnDyc11vmeCWRRBfK+NJ1jeh/5UhUbakFrPpSCGHi9abnsZMgR\nA2DC4CExAgMBAAECggEADw9oZq8yPpNMXac8hZYOuQySdnHtzTPn5E0Uq0gupW7m\nYjCTVLsGaDX+I7y7NbIpSDTaaKZLMmUHX9gWV5TLIbRCG2mJV6LMtmZUUwZL+t30\nvbVqDdgcRG5v/8sdZCTptOLNL+FjS8eSndZsiq73eT5aKcpfkPgVWs0nslloiVba\nc3FmbWnGoQafHD/m8WZFznUZQt+urRkb47Tvy9Vh0t4HpnYZm0S2JNkZ4QdslxUR\nGK8RLr1R41FjckN1NxUbKDcPjyZu2iIujUDuwbyfek6zzUXZnyTvxrrO6OIu5h6Q\nRUYhOKuMju+mTY8Vf8sJZaT3S9g6hqRO17EF57AUxQKBgQD3EHub8GAQoN9S58Lh\nIjqNLwJNuxfhZE6hlFduphMTTmm6nMAH7AE/zcKEna85279AlY6bNq6wkMQukBXe\n1VZ7bZRs9fhkkWrPxGWSDiMU0Sx+0ZweE7m85b4eSfbaMl2aUy2QA3gxnrqtDQu5\n2j7nSqBaRfn7aEqT8qUaRvszbQKBgQDsa6yEsYY+Vkr3jU1JV4LEGu2XMKLokG9v\nSbtzQn93h8x+XQ4hGQnVlNtLFKAtLNDSXTt1+QMUen7cPwe4Vw5MlBu41+rJozt0\nUiSYLIvkcBljvtOoWg7r1Zamw8juj4vuMt8EVQ7VbMq7PJxXE0SFmXNbxiFaPgrg\nc8YOsaGGVQKBgEw2EWsw4vE+LqVsSHkaDeWvMo63v84PGxJMqAvBvvCdp4+g+rt2\n2YvM9MvjuEGov340pCDM5WYhweJ7H8P1GxBH5RkXZt/e24vrkUlUgw3Q2GDmV7oP\na6QRWmwNdNAp6SXJsqxR5amoxPzMoWlbITxHkN9H5qzepuKsXrGUY7ihAoGAEHBo\nPY3OhNUhP1de8WOZXyN0M9gY68znQrjAxQHxtREHQh4cVmbUTTqdiPn1LU75cjcz\nZD+dXDYsTgo/8ixzfRWrW83/sGeeQbdYfhBS5d55lXr2YrVoZjOi1xO0DAqFM1ns\nMfPsJSD8c8qCIHfhgtyprc74ELtRrEvAkNL/JUUCgYB1sEpBGWQ4W277OSRYFyYR\nonBOvOrMRk7KLBSX5n8D7jGKU0ZYiMhahGulqWNXopezlYybx4P+rR4UA8EDq4D2\nib/F8Fo7K7Q4wKTfHr1Bl1KWcKIsUkBkTwAaFuVIX2gh+lifBGu3bW22qTuHrF+y\naqTXLsS+CKjmlPSBMBXI/A==\n-----END PRIVATE KEY-----\n",
      "client_email": "cesaevents@cesaevents.iam.gserviceaccount.com",
      "client_id": "114191419379102466182",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cesaevents%40cesaevents.iam.gserviceaccount.com"
    }
  ''';
  static final _spreadsheetId = '1AaIzCJSBdYMhDTDTSyI8EZw5yXPrL_k_oVY47CAHsoU';

  static final _gsheet = GSheets(_credentials);

  static Worksheet? _participantSheet;

  late bool isLoading = false;

  set loading(bool load){
    this.isLoading = load;
  } 

  Future setHeader(List<String> header)async{
    this.header = header;
  }

  Future init() async{
    try{
      //Acessando a planilha do google
      final spreadsheet = await _gsheet.spreadsheet(_spreadsheetId);

      //Acessando a pagina da planilha
      _participantSheet = await _getWorkSheet(spreadsheet, title: 'Participantes');

      //Salvando primeira linha na planilha
      final firstRow = header;
      _participantSheet!.values.insertRow(1, firstRow);
    }catch(e){
      print('Init error: $e');
    }

    
  }
  //Acessa a planilha no google Sheets
  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
      required String title,
    })async{
      try{
        return await spreadsheet.addWorksheet(title);
      }catch(e){
        return spreadsheet.worksheetByTitle(title)!;
      }
    }
    
  //Insere dados na planilha
  static Future insert(List<Map<String, dynamic>> rowList)async{
    if(_participantSheet == null) return;
    
     _participantSheet!.values.map.appendRows(rowList);
  }

  static Future getRowCount() async{
    if(_participantSheet == null) return 0;

    final lasRow = await _participantSheet!.values.lastRow();

    return lasRow == null ? 0 :  int.tryParse(lasRow.first) ?? 0;
  }

  //Retorna participante da planilha pelo ID
  static Future getById(int id)async{
    if(_participantSheet == null) return 0;

    //Retorna map da linha selecionada pelo ID
    final json = await _participantSheet!.values.map.rowByKey(id, fromColumn: 1);

    //converte resultado em um obejto Participante
    return json == null ? null : Participants.fromJson(json);
  }

  //Retorna todos os participantes da planilha
  static Future<List<Participants>> getAll()async{
    if(_participantSheet == null) return <Participants>[];

    final participants = await _participantSheet!.values.map.allRows();

    return participants == null ? <Participants>[] : participants.map(Participants.fromJson).toList();

  }

  //Salvando nota na planilha
  static Future<bool> update(int id, Map<String, dynamic> participant)async{
    if(_participantSheet == null) return false;

    return _participantSheet!.values.map.insertRowByKey(id, participant);
  }

  //Salvando celular independente
  static Future<bool> updateCell({required int id, required String key, required String value})async{
    if(_participantSheet == null) return false;

    return _participantSheet!.values.insertValueByKeys(value, columnKey: key, rowKey: id);

  }


}
