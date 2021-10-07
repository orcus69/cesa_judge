import 'package:cesa_events_judge/models/event/event.dart';
import 'package:cesa_events_judge/models/event/eventManager.dart';
import 'package:cesa_events_judge/screens/createEventScreen/createEventScreen.dart';
import 'package:cesa_events_judge/screens/enterEventScreen/components/qrViewer.dart';
import 'package:cesa_events_judge/screens/enterEventScreen/enterEventScreen.dart';
import 'package:cesa_events_judge/screens/home/home.dart';
import 'package:cesa_events_judge/screens/judgeScreen/judgeScreen.dart';
import 'package:cesa_events_judge/screens/partipantScreen/participantScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Event(),
          lazy: false,
        ),
      ],
       child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: Scaffold(
            body: HomeScreen(),
          ),
          onGenerateRoute: (settings){
              switch(settings.name){  
                case '/createEvent':
                  return MaterialPageRoute(
                    builder: (_) => CreateEventScreen(),
                  ); 
                case '/enterEvent':
                  return MaterialPageRoute(
                    builder: (_) => EnterEventScreen(),
                  );
                case '/qrCodeView':
                  return MaterialPageRoute(
                    builder: (_) => QRViewExample(),
                  );
                case '/judge':
                  return MaterialPageRoute(
                    builder: (_) => JudgeScreen(settings.arguments as String),
                  );
                case '/participant':
                  return MaterialPageRoute(
                    builder: (_) => ParticipantScreen(settings.arguments as String),
                  );
                case '/':
                default:
                  return MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                      settings: settings
                  );
              }
            },
        ),
    );
  }
}

