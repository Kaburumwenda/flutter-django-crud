import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UpdatePage extends StatefulWidget {
  final int id;
  final String body;
  const UpdatePage({ Key key, this.id, this.body }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Client client = http.Client();
  String updateUrl = 'https://5a32-41-212-98-222.ngrok.io/notes/update/';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.body;
    // print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 5,
          ),
          ElevatedButton(
            onPressed: (){
              client.put(Uri.parse('https://5a32-41-212-98-222.ngrok.io/notes/update/${widget.id}/'),
               body:{"body": controller.text} );
              Navigator.pop(context);
            }, 
            child: const Text('Update note')
            )
        ],
      ),
    );
  }
}