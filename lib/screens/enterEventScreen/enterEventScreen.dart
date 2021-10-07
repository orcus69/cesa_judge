import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:cesa_events_judge/models/event/eventManager.dart';
import 'package:flutter/material.dart';

class EnterEventScreen extends StatefulWidget{

  @override
  _EnterEventScreenState createState() => _EnterEventScreenState();
}

class _EnterEventScreenState extends State<EnterEventScreen> {
  final TextEditingController codeControler = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  @override
  void initState(){
    super.initState();
  }

  @override 
  Widget build(BuildContext context){
    final key = new GlobalKey<ScaffoldState>();
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
                                child: isLoading ? Container(alignment: Alignment.center ,child: CircularProgressIndicator(color: Colors.white,)) : ButtonWidget(
                                  color: Color.fromARGB(255, 38, 164, 255),
                                  textColor: Colors.white,
                                  text: 'Entrar',
                                  onClicked: ()async{
                                    
                                    
                                    if(formKey.currentState!.validate()){
                                      setState(() => isLoading = true);
                                      await Future.delayed(Duration(seconds: 2));

                                      //Verifica se o codigo do evento existe
                                      final isValideQr = await EventManager.validateQrCode(codeControler.text);

                                      if(isValideQr!){
                                        scaffoldKey.currentState!.showSnackBar(
                                           SnackBar(
                                              content: Text('Entrando...'),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 1),
                                            )
                                        );
                                        await Future.delayed(Duration(seconds: 1));
                                        await Navigator.of(context).pushNamed('/judge', arguments: codeControler.text);
                                      }else{
                                        scaffoldKey.currentState!.showSnackBar(
                                           SnackBar(
                                              content: Text('Código do evento inválido'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                            )
                                        );
                                        formKey.currentState!.reset();
                                      }


                                    }
                                    setState(() => isLoading = false);
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