import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
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
            child: Column(
              children: [

                //LOGO CESA
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  constraints: BoxConstraints.expand(height: 300.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logoWHITE.png",),
                      scale: 1.75
                    ),
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: Column(
                    children: [
                      
                      //Botão de criar Eventos
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: ButtonWidget(
                            color: Colors.white,
                            textColor: Colors.black,
                            text: 'Cadastrar Evento',
                            onClicked: () => Navigator.of(context).pushNamed("/createEvent"),
                            
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
    
                      //Botão de Entrar no Evento
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: ButtonWidget(
                            color: Color.fromARGB(255, 38, 164, 255),
                            textColor: Colors.white,
                            text: 'Entrar',
                            onClicked: () => Navigator.of(context).pushNamed("/enterEvent"),
                            
                          ),
                        ),
                      ),
                    ],
                  ),

                ),

                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 10),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        '''Created by C.E.S.A
Software development''',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.171875,
                          fontSize: 12.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 255, 255, 255),
                
                          /* letterSpacing: 0.0, */
                        ),
                      )
                    ),
                  ),
                ),
        
              ],
            ),
          ),
        ]
      ),
    );
  }
}