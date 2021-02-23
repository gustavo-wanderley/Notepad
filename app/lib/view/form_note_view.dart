import 'package:app/service/data_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormNoteView extends StatefulWidget {
  @override
  _FormNoteViewState createState() => _FormNoteViewState();
}

class _FormNoteViewState extends State<FormNoteView> {

  Map<String, Object> _note = {
    "titulo": "",
    "data": null,
    "nota": "",
  };

  _addNota(BuildContext context) {

    setState(() {
      _note["data"] = DateTime.now();  
    });
    Provider.of<NoteDao>(context, listen: false).insertNote(
      Note(
        name: _note["titulo"] as String,
        date: _note["data"],
        summary: _note["nota"],
      )
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloco de Notas"),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {
            
          }),
          IconButton(icon: Icon(Icons.check), onPressed: (){
            _addNota(context);
          })
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Título",
                        border: InputBorder.none
                      ),
                      onChanged: (txt){
                        setState(() {
                          _note["titulo"] = txt;
                        });
                      },
                      maxLength: 30,
                    ),
                  )),
              SizedBox(
                height: 1,
              ),
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                      child: TextField(
                        decoration: InputDecoration(
                              labelText: "Sua anotação",
                              border: InputBorder.none
                            ),
                        keyboardType: TextInputType.multiline,
                        maxLength: 10000,
                        maxLines: null,
                        onChanged: (txt){
                        setState(() {
                          _note["nota"] = txt;
                        });
                      },
                      ),
                    ),
                    SizedBox(height: 15,),

                    Text("20/10/2021"),
                    SizedBox(height: 10,)
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
