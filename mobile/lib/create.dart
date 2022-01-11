import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({ Key key }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  Client client = http.Client();
  String createUrl = 'https://5a32-41-212-98-222.ngrok.io/notes/create/';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 5,
          ),
          ElevatedButton(
            onPressed: (){
              client.post(Uri.parse(createUrl),body:{"body": controller.text} );
              Navigator.pop(context);
            }, 
            child: const Text('create note')
            )
        ],
      ),
    );
  }
}