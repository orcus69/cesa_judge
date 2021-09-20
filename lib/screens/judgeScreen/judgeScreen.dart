import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:flutter/material.dart';

class JudgeScreen extends StatefulWidget{

  JudgeScreen(this.eventCode);

  final String eventCode;

  @override
  _JudgeScreenState createState() => _JudgeScreenState();
}

class _JudgeScreenState extends State<JudgeScreen> {
  final TextEditingController nameControler = TextEditingController();

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
                      title: Text("#${widget.eventCode.toString()}", style: TextStyle(color: Colors.white),),
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
                                  borderRadius: BorderRadius.circular(5),
                                  child: Icon(Icons.account_circle_rounded, size: 250, color: Colors.white,),
                                ),
                              ),
                              SizedBox(height: 20,),

                              //DIGITAR CODIGO DO EVENTO
                              Text(
                                "Digite seu nome", 
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
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    hintText: 'João Alberto',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (name) {
                                    if (name!.isEmpty) {
                                      return 'Nome precisa ser preenchido';
                                    }
                                    return null;
                                  },
                                  onSaved: (name){},
                                ),
                              ),
                              
                              SizedBox(height: 25,),
                              
                              //BOTÃO DE ENTRAR
                              SizedBox(
                                width: double.infinity,
                                child: isLoading ? Container(alignment: Alignment.center ,child: CircularProgressIndicator(color: Colors.white,)) : ButtonWidget(
                                  color: Color.fromARGB(255, 38, 164, 255),
                                  textColor: Colors.white,
                                  text: 'Avaliar Participantes',
                                  onClicked: ()async{
                                    setState(() => isLoading = true);
                                    await Future.delayed(Duration(seconds: 2));
                                    
                                    await Navigator.of(context).pushNamed('/participant', arguments: widget.eventCode);
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