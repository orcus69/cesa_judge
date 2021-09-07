import 'package:flutter/material.dart';

class EnterEventScreen extends StatelessWidget{

  final TextEditingController codeControler = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override 
  Widget build(BuildContext context){
    final key = new GlobalKey<ScaffoldState>();
    String _textCode = "";
    return Scaffold(
      key: scaffoldKey,
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
                      title: Text("Entrar", style: TextStyle(color: Colors.white),),
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
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushNamed('/qrCodeView');
                                },
                                child: Container(
                                  width: 246.0,
                                  height: 238.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children:[ 
                                        Container(
                                          color: Color.fromARGB(255, 248, 248, 248),
                                        ),
                                        Icon(Icons.qr_code_scanner_rounded, size: 220,),
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),

                              //DIGITAR CODIGO DO EVENTO
                              Text(
                                "Código do Evento", 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontFamily: "Roboto", 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20,),
                              Card(
                                child: TextFormField(
                                  controller: codeControler,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    hintText: 'CSA00001',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (name) {
                                    if (name!.isEmpty) {
                                      return 'Digite um código válido';
                                    }
                                    return null;
                                  },
                                  onSaved: (name){},
                                ),
                              ),
                              
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
                                  onPressed:(){
                                    if(formKey.currentState!.validate()){
                                      Navigator.of(context).pushNamed('/judge', arguments: codeControler.text);
                                    }
                                  },
                                  child: Text(
                                    "Entrar".toUpperCase(),
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