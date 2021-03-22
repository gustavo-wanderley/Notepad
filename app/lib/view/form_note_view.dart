import 'package:app/service/data_base.dart';
import 'package:app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormNoteView extends StatefulWidget {
  final bool isEdit;
  FormNoteView({this.isEdit});
  @override
  _FormNoteViewState createState() => _FormNoteViewState();
}

class _FormNoteViewState extends State<FormNoteView> {
  TextEditingController editingControllerTitle = TextEditingController();
  TextEditingController editingControllerNote = TextEditingController();
  // ignore: unused_field
  Map<String, Object> _note = {
    "titulo": "",
    "data": null,
    "nota": "",
  };

  _addNota(BuildContext context) {
    // ignore: missing_required_param
    Provider.of<NoteDao>(context, listen: false).insertNote(Note(
      name: editingControllerTitle.text,
      date: DateTime.now(),
      summary: editingControllerNote.text,
    ));
    Navigator.pop(context);
  }

  void _updateNote(BuildContext context, Note note) {
    Provider.of<NoteDao>(context, listen: false).updateNote(note.copyWith(
        name: editingControllerTitle.text,
        summary: editingControllerNote.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      Note note = args["note"] as Note;
      setState(() {
        editingControllerTitle.text = note.name;
        editingControllerNote.text = note.summary;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloco de Notas"),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (args == null) {
                  _addNota(context);
                } else {
                  Note note = args["note"] as Note;
                  _updateNote(context, note);
                }
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Título", border: InputBorder.none),
                      controller: editingControllerTitle,
                      maxLength: 30,
                    ),
                  )),
              SizedBox(
                height: 1,
              ),
              Card(
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 7),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Sua anotação",
                            border: InputBorder.none),
                        keyboardType: TextInputType.multiline,
                        maxLength: 10000,
                        minLines: 10,
                        maxLines: null,
                        controller: editingControllerNote,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(Utils.converterDate(DateTime.now())),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
