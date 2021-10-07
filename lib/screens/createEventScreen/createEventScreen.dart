import 'dart:html';

import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:cesa_events_judge/models/event/event.dart';
import 'package:cesa_events_judge/models/event/eventManager.dart';
import 'package:cesa_events_judge/screens/createEventScreen/components/qrCodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget{

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final TextEditingController titleControler = TextEditingController();

  final TextEditingController descriptionControler = TextEditingController();

  final TextEditingController dateTimeControler = TextEditingController();

  final TextEditingController jugdControler = TextEditingController();

  final TextEditingController linkController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Event event = Event();

  bool isLoading = false;

  @override 
  Widget build(BuildContext context){

    final key = new GlobalKey<ScaffoldState>();
 
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
                          child: Consumer<EventManager>(
                            builder: (_, eventManager, __){
                              return Column(
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
                                      enabled: !eventManager.loading,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 20),
                                        labelText: 'Titulo',
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (title) {
                                        if (title!.length < 6) {
                                          return 'Titulo muito curto';
                                        }
                                        return null;
                                      },
                                      onSaved: (title) => event.title = title!,
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
                                      enabled: !eventManager.loading,
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
                                      onSaved: (desc) => event.description = desc!,
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
                                      enabled: !eventManager.loading,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 4),
                                        labelText: 'DD/MM/AAAA',
                                        border: InputBorder.none,
                                        icon: Icon(Icons.calendar_today),
                                      ),
                                      keyboardType: TextInputType.datetime,
                                      validator: (date) {
                                        if(date!.isEmpty)
                                            return null;
                                        if(date.length != 10)
                                            return 'Enter date in DD / MM / YYYY format';
                                        return null; 
                                      },
                                      onSaved: (date) => event.date = date!,
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
                                      enabled: !eventManager.loading,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 20),
                                        labelText: 'Quantidade de juizes',
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (judge) {
                                        if (judge!.isEmpty) {
                                          return 'Defina a quantidade de juizes do evento';
                                        }
                                        if(int.tryParse(judge.toString())! >= 10)
                                            return 'O numero de juizes não pode exceder 10';
                                        return null;
                                      },
                                      onSaved: (judge) => event.juizes = int.tryParse(judge.toString())!,
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
                                      enabled: !eventManager.loading,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 20),
                                        labelText: 'Quantidade de notas a serem somadas',
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      validator: (notes) {
                                        if (notes!.isEmpty) {
                                          return 'Defina a quantidade de notas a serem somadas';
                                        }
                                        if(int.tryParse(notes.toString())! >= 10)
                                            return 'O numero de notas a serem somadas não deve exceder 10';
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
                                      enabled: !eventManager.loading,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 4),
                                        hintText: 'https://docs.google.com/spreadsheets/d/IDPLANILHAGOOGLESHEETS',
                                        border: InputBorder.none,
                                        icon: Icon(Icons.link_outlined),
                                      ),
                                      validator: (link) {
                                        if (link!.isEmpty) {
                                          return 'O link precisa ser preenchido';
                                        }
                                        if(!link.contains('https://docs.google.com/spreadsheets/d/'))
                                            return 'O link da tabela precisa estar publico no Google Sheets';
                                        return null;
                                      },
                                      onSaved: (link) => event.linkSheet = link!,
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                      
                                  SizedBox(
                                    width: double.infinity,
                                    child: eventManager.loading 
                                      ? Container(alignment: Alignment.center ,child: CircularProgressIndicator(color: Colors.white,))
                                      : ButtonWidget(
                                      color: Color.fromARGB(255, 38, 164, 255),
                                      textColor: Colors.white,
                                      text: 'Criar Evento',
                                      onClicked: eventManager.loading ? (){} : ()async{

                                        if(formKey.currentState!.validate()){
                                          //Salva dados no objeto Event
                                          formKey.currentState!.save();

                                          //Cria evento no firebase
                                          eventManager.createEvent(
                                            event: event, 
                                            onSuccess:(){
                                              
                                            },
                                            onFail: (e){
                                              // ignore: deprecated_member_use
                                              scaffoldKey.currentState!.showSnackBar(
                                                SnackBar(
                                                  content: Text('Falha ao cadastrar: $e'),
                                                  backgroundColor: Colors.red,
                                                  duration: Duration(seconds: 2),
                                                )
                                              );
                                            },
                                          );

                                          final eventId = await eventManager.getEventId();

                                          await Future.delayed(Duration(seconds: 2));

                                          await showDialog(
                                            context: context, 
                                            builder: (_){
                                              return QrcodeWidget( eventId: eventId-1, keys: key);
                                            }
                                          );
                                        }
                                      },
                                      
                                    ),
                                  ),
                                ],
                              
                              );
                            }
                          )
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