import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/create.dart';
import 'package:mobile/update.dart';
import 'package:mobile/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:const MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];
  String retrieveurl = 'https://5a32-41-212-98-222.ngrok.io/notes/';
  String deleteurl = 'https://5a32-41-212-98-222.ngrok.io/notes/delete/';

  @override
  void initState() {
    _retrieveNote();
    super.initState();
  }

  _retrieveNote() async {
    notes = [];

    List response = json.decode((await client.get(Uri.parse(retrieveurl))).body);
    response.forEach((element) {
      notes.add(Note.fromJson(element));
    });
    setState(() {});
  }

  void _deleteNote(int id){
    client.delete(Uri.parse('https://5a32-41-212-98-222.ngrok.io/notes/delete/${id}/'));
    _retrieveNote();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('django flutter demo')
      ),
      body: RefreshIndicator(
        onRefresh:() async {
          _retrieveNote();
        },
        child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title:Text(notes[index].body),
            onTap: (){
              Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => 
               UpdatePage(
                id: notes[index].id,
                body: notes[index].body,
              ) 
              ));
            },
            trailing: IconButton(
              onPressed: (){
                _deleteNote(notes[index].id);
              }, 
              icon:const Icon(Icons.delete),
              ),
          );
        }
        ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const CreatePage() ));
        },
        child:const Icon(Icons.add)
        ),
    );
  }
}