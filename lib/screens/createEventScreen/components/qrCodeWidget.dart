import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeWidget extends StatefulWidget {
  const QrcodeWidget({ Key? key, required this.keys, required this.eventId}) : super(key: key);

  final int eventId;
  final GlobalKey<ScaffoldState> keys;

  @override
  _QrcodeWidgetState createState() => _QrcodeWidgetState();
}

class _QrcodeWidgetState extends State<QrcodeWidget> {
  String _textCode = '';
  
 
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '''Código do evento''',
            overflow: TextOverflow.visible,
            style: TextStyle(
              height: 1.171875,
              fontSize: 18.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              color: Colors.black,

              /* letterSpacing: 0.0, */
            ),
          ),
          SizedBox(height: 8,),
          //QR CODE
          Container(
            width: 266.0,
            height: 247.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                alignment: Alignment.center,
                children:[ 
                  
                  Container(
                    color: Color.fromARGB(255, 248, 248, 248),
                  ),
                  QrImage(
                    data: 'CSA000${widget.eventId}',
                    version: QrVersions.auto,
                    size: 220,
                    gapless: false,
                    embeddedImage: AssetImage('assets/logoWHITE.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(80, 80),
                    ),
                  )
                ]
              ),
            ),
          ),
          SizedBox(height: 8,),

          //CODIGO GERADO
          Container(
            width: double.infinity,
            height: 33.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Color.fromARGB(255, 228, 221, 221),
                  ),
                  Text(

                  'CSA000${widget.eventId}', 
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    /* letterSpacing: 0.0, */
                  ),
                ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          //COPIAR CODIGO
          GestureDetector(
            onTap: (){ 
              setState(() => _textCode = 'CSA000${widget.eventId}');
              Clipboard.setData(ClipboardData(text: _textCode));
              // ignore: deprecated_member_use
              widget.keys.currentState!.showSnackBar(
                SnackBar(content: Text("Código copiado"), duration: Duration(seconds: 2),)
              );
            },
            child: Text(
              '''Copiar código''',
              overflow: TextOverflow.visible,
              style: TextStyle(
                height: 1.171875,
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 0, 163, 255),
          
                /* letterSpacing: 0.0, */
              ),
            ),
          )
        ],
      ),

    );
  }
}