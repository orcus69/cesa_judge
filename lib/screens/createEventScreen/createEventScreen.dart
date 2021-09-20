import 'package:cesa_events_judge/api/sheet/participantsSheetApi.dart';
import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateEventScreen extends StatelessWidget{

  final TextEditingController titleControler = TextEditingController();
  final TextEditingController descriptionControler = TextEditingController();
  final TextEditingController dateTimeControler = TextEditingController();
  final TextEditingController jugdControler = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override 
  Widget build(BuildContext context){
    final participantsSheetApi = ParticipantsSheetApi();

    final key = new GlobalKey<ScaffoldState>();

    final String _textCode = "CSA00001";

    return Scaffold(
      key: key,
      body: Form(
        key: formKey,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -1.0),
                  end: Alignment(1.0, 1.0),
                  stops: [0.0, 1.0],
                  colors: [
                    Color.fromARGB(255, 136, 3, 183),
                    Color.fromARGB(255, 0, 168, 179)
                  ],
                ),
              ),
            ),
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text("Criar Evento", style: TextStyle(color: Colors.white),),
                      centerTitle: true,
                    ),
                  ),
      
                  //Formulario de criação do evento
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:30, right: 20, bottom: 20, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Título do evento", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    labelText: 'Titulo',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (name) {
                                    if (name!.length < 6) {
                                      return 'Titulo muito curto';
                                    }
                                    return null;
                                  },
                                  onSaved: (name){},
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                "Descrição", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    labelText: 'Descrição',
                                    border: InputBorder.none,
                                  ),
                                  maxLines: null,
                                  validator: (desc) {
                                    if (desc!.length < 10) {
                                      return 'Descrição muito curta';
                                    }
                                    return null;
                                  },
                                  onSaved: (desc) {},
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                "Data", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 4),
                                    labelText: 'DD/MM/AAAA',
                                    border: InputBorder.none,
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                  keyboardType: TextInputType.datetime,
                                  validator: (date) {
                                    if (date!.isEmpty) {
                                      return 'Data precisa ser preenchida';
                                    }
                                    return null;
                                  },
                                  onSaved: (desc) {},
                                ),
                              ),
                              SizedBox(height: 8,),
                              Text(
                                "Juízes", 
                                style: TextStyle(
                                  
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    labelText: 'Quantidade de juizes',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (name) {
                                    if (name!.isEmpty) {
                                      return 'Defina a quantidade de juizes do evento';
                                    }
                                    return null;
                                  },
                                  onSaved: (name){},
                                ),
                              ),
                              Text(
                                "Quantidade de notas", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    labelText: 'Quantidade de notas a serem somadas',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (name) {
                                    if (name!.isEmpty) {
                                      return 'Defina a quantidade de notas a serem somadas';
                                    }
                                    return null;
                                  },
                                  onSaved: (name){},
                                ),
                              ),
                              Text(
                                "Link da planilha de participantes", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  controller: linkController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 4),
                                    hintText: 'https://https://docs.google.com/spreadsheets/d/IDPLANILHAGOOGLESHEETS',
                                    border: InputBorder.none,
                                    icon: Icon(Icons.link_outlined),
                                  ),
                                  validator: (link) {
                                    if (link!.isEmpty) {
                                      return 'O link precisa ser preenchido';
                                    }
                                    return null;
                                  },
                                  onSaved: (link){},
                                ),
                              ),
                              SizedBox(height: 8,),

                              SizedBox(
                                width: double.infinity,
                                child: ButtonWidget(
                                  color: Color.fromARGB(255, 38, 164, 255),
                                  textColor: Colors.white,
                                  text: 'Criar Evento',
                                  onClicked: (){
                                    participantsSheetApi.init();

                                    participantsSheetApi.setHeader(['id', 'name', 'n1', 'n2', 'n3']);
                                    
                                    showDialog(
                                      context: context, 
                                      builder: (_){
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '''Código do evento''',
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                  height: 1.171875,
                                                  fontSize: 18.0,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,

                                                  /* letterSpacing: 0.0, */
                                                ),
                                              ),
                                              SizedBox(height: 8,),
                                              //QR CODE
                                              Container(
                                                width: 266.0,
                                                height: 247.0,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children:[ 
                                                      
                                                      Container(
                                                        color: Color.fromARGB(255, 248, 248, 248),
                                                      ),
                                                      QrImage(
                                                        data: 'CSA0001',
                                                        version: QrVersions.auto,
                                                        size: 220,
                                                        gapless: false,
                                                        embeddedImage: AssetImage('assets/logoWHITE.png'),
                                                        embeddedImageStyle: QrEmbeddedImageStyle(
                                                          size: Size(80, 80),
                                                        ),
                                                      )
                                                    ]
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8,),

                                              //CODIGO GERADO
                                              Container(
                                                width: double.infinity,
                                                height: 33.0,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        color: Color.fromARGB(255, 228, 221, 221),
                                                      ),
                                                      Text(

                                                      _textCode.toUpperCase(), 
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: 'Roboto',
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.black,
                                                        /* letterSpacing: 0.0, */
                                                      ),
                                                    ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8,),
                                              //COPIAR CODIGO
                                              GestureDetector(
                                                onTap: (){ 
                                                  Clipboard.setData(ClipboardData(text: _textCode));
                                                  // ignore: deprecated_member_use
                                                  key.currentState!.showSnackBar(
                                                    SnackBar(content: Text("Código copiado"), duration: Duration(seconds: 2),)
                                                  );
                                                },
                                                child: Text(
                                                  '''Copiar código''',
                                                  overflow: TextOverflow.visible,
                                                  style: TextStyle(
                                                    height: 1.171875,
                                                    fontSize: 18.0,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(255, 0, 163, 255),
                                              
                                                    /* letterSpacing: 0.0, */
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                        );
                                      }
                                    );
                                  },
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}