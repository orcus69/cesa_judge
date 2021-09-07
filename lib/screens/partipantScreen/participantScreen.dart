import 'package:flutter/material.dart';

class ParticipantScreen extends StatelessWidget{

  ParticipantScreen(this.eventCode);

  final String eventCode;

  final TextEditingController nameControler = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text("#${eventCode.toString()}", style: TextStyle(color: Colors.white),),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              //QRCODE SCANNER
                              Container(
                                width: 266.0,
                                height: 247.0,
                                child: ClipRRect(
                                  child: Card(
                                      color: Color.fromARGB(255, 255,255,250),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text('Test'),

                                              Row(
                                                children: [
                                                  Container(
                                                    child: TextFormField(
                                                      decoration: const InputDecoration(
                                                        hintText: '10.0',
                                                        border: InputBorder.none,
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      validator: (name) {
                                                        if (name!.isEmpty) {
                                                          return 'Nota precisa ser preenchido';
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (name){},
                                                    ),
                                                  ),

                                                  Column(
                                                    children: [
                                                      Icon(Icons.plus_one_rounded),
                                                      Icon(Icons.exposure_minus_1_rounded),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                              SizedBox(height: 20,),

                              SizedBox(height: 20,),
                              
                              
                              //BOTÃO DE ENTRAR
                              SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.only(top:20, bottom: 20),
                                  
                                  //TODO: ENTRAR NO EVENTO QRCODE
                                  onPressed:(){},
                                  child: Text(
                                    "Avaliar Participantes".toUpperCase(),
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      height: 1.171875,
                                      fontSize: 18.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                    ),
                                  ),
                                  color: Color.fromARGB(255, 38, 164, 255),
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