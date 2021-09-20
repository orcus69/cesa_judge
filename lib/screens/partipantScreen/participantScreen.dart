import 'package:cesa_events_judge/api/sheet/participantsSheetApi.dart';
import 'package:cesa_events_judge/models/participants/participants.dart';
import 'package:cesa_events_judge/screens/partipantScreen/components/navigateParticipantsWidget.dart';
import 'package:cesa_events_judge/screens/partipantScreen/components/participantFormWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantScreen extends StatefulWidget{

  ParticipantScreen(this.eventCode);

  final String eventCode;

  @override
  _ParticipantScreenState createState() => _ParticipantScreenState();
}

class _ParticipantScreenState extends State<ParticipantScreen> {

  List<Participants>? participants = [];

  final participantsSheetApi = ParticipantsSheetApi();

  int index = 0;

  @override
  void initState(){
    super.initState();

    getParticipants();
    
  }
  Future getParticipants()async{
    await participantsSheetApi.init();
    final participants = await ParticipantsSheetApi.getAll();

    setState((){
      this.participants = participants;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 136, 3, 183),
          flexibleSpace: FlexibleSpaceBar(
            title: Text("#${widget.eventCode}", style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),
        ),
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
                  constraints: BoxConstraints.expand(height: 225.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logoWHITE.png",),
                      scale: 1.75
                    ),
                  ),
                ),

                SizedBox(height: 4,),
                
                Container(
                  child: Column(
                    children: [
                      //Botão de Entrar no Evento
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0, right: 60),
                        child: SizedBox(
                          width: double.infinity,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ParticipantFormWidget(
                                participant: participants!.isEmpty ? null : participants![index],
                                onSavedParticipant: (participant)async{
                                  await ParticipantsSheetApi.update(participant.id!, participant.toJson());
                                }
                              ),

                              const SizedBox(height: 16,),
                              if(participants!.isNotEmpty) buildUserControls(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
  Widget buildUserControls() => NavigateParticipantsWidget(
      text: '''${index+1}/${participants!.length} 
Participantes''',
      onClickedNext: (){
        final nextIndex = index >= participants!.length - 1 ? 0 : index + 1; 

        setState(() => index = nextIndex);
      },
      onClickedPrevious: (){
        final previousIndex = index <= 0 ? participants!.length - 1 : index - 1; 

        setState(() => index = previousIndex);
      }
    );
}

