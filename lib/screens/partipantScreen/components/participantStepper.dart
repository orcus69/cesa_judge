import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {

  StepperPage({required this.eventCode});

  final String eventCode;


  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        middle: Text('#${widget.eventCode.toUpperCase()}', style: TextStyle(color: Colors.white,)),
      ),
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
            child: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                switch (orientation) {
                  case Orientation.portrait:
                    return _buildStepper(StepperType.vertical);
                  case Orientation.landscape:
                    return _buildStepper(StepperType.horizontal);
                  default:
                    throw UnimplementedError(orientation.toString());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 5;

    return CupertinoStepper(
      controlsBuilder: (BuildContext context,
          {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: onStepCancel,
              child: const Text('VOLTAR', style: TextStyle(color: CupertinoColors.systemGrey, fontWeight: FontWeight.bold),),
            ),
            TextButton(
              onPressed: onStepContinue,
              child: const Text('AVALIAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ],
        );
      },
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
      onStepContinue: canContinue ? () => setState(() => ++currentStep): null,
      steps: [
        //TODO: Returnar lista de participantes
        for (var i = 0; i < 5; ++i)
          _buildStep(
            title: Text('PARTICIPANTE ${i + 1}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep ? StepState.complete : StepState.indexed,
          )
      ],
    );
  }

  Step _buildStep({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      subtitle: Text('Subtitle', style: TextStyle(color: Colors.white,),),
      state: state,
      isActive: isActive,
      content: LimitedBox(
        maxWidth: 300,
        maxHeight: 300,
        child: Container(color: CupertinoColors.systemGrey),
      ),
    );
  }
}