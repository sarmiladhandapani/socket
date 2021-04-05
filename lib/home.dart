import 'package:flutter/material.dart';
import 'package:socket/socket.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}



class _HomepageState extends State<Homepage> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Metting id"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 256,
              margin: const EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Socket', labelText: 'Socket'),
                controller: userNameController,
              ),
            ),
            RaisedButton(
              child: Text("Connected"),
              onPressed: () {
                _navigateHome(context);
              },
            )
          ],
        ),
      ),
    );
  }

  _navigateHome(BuildContext context) async {
    String user = userNameController.text;
    print(user);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => socketpage(user:user)));
  }
}