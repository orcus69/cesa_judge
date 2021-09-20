import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:cesa_events_judge/models/participants/participants.dart';
import 'package:flutter/material.dart';

class ParticipantFormWidget extends StatefulWidget {
  final Participants? participant;
  final ValueChanged<Participants> onSavedParticipant;

  const ParticipantFormWidget({
    Key? key,
    this.participant,
    required this.onSavedParticipant,
  }) : super(key: key);


  @override
  _ParticipantFormWidgetState createState() => _ParticipantFormWidgetState();
}

class _ParticipantFormWidgetState extends State<ParticipantFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerNote;

  

  bool isLoading = false;


  @override
  void initState(){
    super.initState();

    initParticipant();
  }

  @override
  void didUpdateWidget(covariant ParticipantFormWidget oldWidget){
    super.didUpdateWidget(oldWidget);
    initParticipant();
  }

  void initParticipant(){

    final name = widget.participant == null ? '' : widget.participant!.name;
    final note = widget.participant == null ? 0  : widget.participant!.note;


    controllerName = TextEditingController(text: name);
    controllerNote = TextEditingController(text: note.toString());
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              const SizedBox(height: 16),

              buildNote(),
              const SizedBox(height: 16),

              isLoading ? CircularProgressIndicator(color: Colors.white,) : buildSubmit() ,
              
            ],
          ),
        ],
      ),
    );
  }

  Widget buildName() => Card(
    child: TextFormField(
      controller: controllerName,
      decoration: InputDecoration(
        labelText: 'Nome',
        border: InputBorder.none,
      )
    ),
  );

  Widget buildNote() => Card(
    child: TextFormField(
      controller: controllerNote,
      decoration: InputDecoration(
        labelText: 'Nota',
        border: InputBorder.none,
      ),
      validator: (note) => note != null && note.isEmpty ? 'Insira uma nota' : null,
    ),
  );

  Widget buildSubmit() => ButtonWidget(
    color: Color.fromARGB(255, 38, 164, 255),
    textColor: Colors.white,
    text: 'Avaliar',
    onClicked: ()async{
      final form = formKey.currentState!;
      final isValid = form.validate();
      if(isValid){
        if(isLoading) return;

        setState(() => isLoading = true);

        final id = widget.participant == null ? null : widget.participant!.id;

        final participants = Participants(
          id: id,
          name: controllerName.text.toString(),
          note: num.tryParse(controllerNote.text.toString()),
        );

        widget.onSavedParticipant(participants);
      }
      await Future.delayed(Duration(seconds: 2));
      setState(() => isLoading = false);
    },
  );
}