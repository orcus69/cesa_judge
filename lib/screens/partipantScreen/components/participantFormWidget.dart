import 'package:cesa_events_judge/common/buttom/buttonWidget.dart';
import 'package:cesa_events_judge/models/participants/participants.dart';
import 'package:flutter/material.dart';

class ParticipantFormWidget extends StatefulWidget {
  final ValueChanged<Partipants> onSavedParticipant;

  const ParticipantFormWidget({
    Key? key,
    required this.onSavedParticipant,
  }) : super(key: key);


  @override
  _ParticipantFormWidgetState createState() => _ParticipantFormWidgetState();
}

class _ParticipantFormWidgetState extends State<ParticipantFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerNote;

  @override
  void initState(){
    super.initState();

    initParticipant();
  }

  void initParticipant(){
    controllerName = TextEditingController();
    controllerNote = TextEditingController();
  }


  @override
  Widget build(BuildContext context) => Form(
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

            buildSubmit(),
          ],
        ),
      ],
    ),
  );

  Widget buildName() => Card(
    child: TextFormField(
      controller: controllerName,
      decoration: InputDecoration(
        labelText: 'Nome',
        border: OutlineInputBorder(),
      )
    ),
  );

  Widget buildNote() => Card(
    child: TextFormField(
      controller: controllerNote,
      decoration: InputDecoration(
        labelText: 'Nota',
        border: OutlineInputBorder(),
      ),
      validator: (note) => note != null && note.isEmpty ? 'Insira uma nota' : null,
    ),
  );

  Widget buildSubmit() => ButtonWidget(
    color: Color.fromARGB(255, 38, 164, 255),
    textColor: Colors.white,
    text: 'Avaliar',
    onClicked: (){
      final form = formKey.currentState!;
      final isValid = form.validate();

      if(isValid){
        final participants = Partipants(
          name: controllerName.text.toString(),
          note: controllerNote.text.toString(),
        );

        widget.onSavedParticipant(participants);
      }
    }
  );
}