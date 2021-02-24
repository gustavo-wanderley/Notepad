import 'package:app/service/data_base.dart';
import 'package:app/service/local_shared.dart';
import 'package:app/widget/note_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NoteDao notesDao = Provider.of<NoteDao>(context);
    Provider.of<LocalShared>(context).getStatus();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloco de Notas"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              })
        ],
      ),
      body: Container(
        child: StreamBuilder(
          builder: (context, snapshot) {
            final notes = snapshot.data ?? List();
            if (notes.length == 0) {
              return Center(
                child: Text("Não possui Notas"),
              );
            } else {
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) =>
                    NoteItemWidget(note: notes[index]),
              );
            }
          },
          stream: Provider.of<LocalShared>(context).ordem
              ? notesDao.watchAllNotesOrder()
              : notesDao.watchAllNotes(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/create-note");
        },
      ),
    );
  }
}
