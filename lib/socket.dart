import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class socketpage extends StatefulWidget {
final String user;
const socketpage({this.user});
  @override
  _socketpageState createState() => _socketpageState();
}



class _socketpageState extends State<socketpage> {

  Socket sockets;
  String copasendname;
  String URI = "https://sokya-app.herokuapp.com";
String socketstatus ="not connected";
String datapring = "null";
  bool loading = true;
initSocket() async {

      print('videoscreen if');
      try {
        print('videoscreen' + URI);
        print('videoscreen' + widget.user);
        sockets = IO.io(
            URI,
            OptionBuilder()
                .setTransports(['websocket'])
                .disableAutoConnect()
                .build());
        sockets.connect();
        print(sockets.connected);
        setState(() {

          sockets.onConnect((data) {
            loading = false;
            socketstatus = "connected";
            if(socketstatus == "connected"){
              setState(() {
                socketstatus = "connected";
              });
            }
            print('videoscreen connected');
            print('videoscreen CO_PATIENT_REQUEST_${widget.user}');
            sockets.on("CO_PATIENT_REQUEST_${widget.user}", (data) {
              print('videoscreen' + data);
              print("levale");
              datapring = data;
            });
          });
        });


      } catch (e) {
        loading = false;
        print(e.toString());
      }

  }
  @override
  void initState() {
    super.initState(
    );

     setState(() {
       loading = true;
     });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
             padding: EdgeInsets.only(top: 20,bottom: 20),
               child: Text("Metting id:"+ widget.user)
           ),
            Container(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                child: Text("Socket connection status:"+ socketstatus)
            ),
            Container(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                child: Text("socket on: CO_PATIENT_REQUEST_${widget.user}" )),
            Container(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                child: Text("socket lission"+ datapring)),
            Container(
              padding: EdgeInsets.only(top: 20,bottom: 20),
              child: RaisedButton(
                child: Text("Connected"),
                onPressed: () {
                  initSocket();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}