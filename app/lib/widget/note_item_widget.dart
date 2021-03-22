import 'package:app/service/data_base.dart';
import 'package:app/service/local_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';

class NoteItemWidget extends StatelessWidget {
  final Note note;
  NoteItemWidget({this.note});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Color(0xffD7CCC8)),
        margin: EdgeInsets.all(10),
        child: NoteItem(note: note));
  }
}

class NoteItem extends StatefulWidget {
  const NoteItem({
    Key key,
    @required this.note,
  }) : super(key: key);

  final Note note;

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    _dialog() {
      return AlertDialog(
        content: Text("Apagar ${widget.note.name} ?"),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                Provider.of<NoteDao>(context, listen: false)
                    .deleteNote(widget.note);
                Navigator.pop(context);
              },
              child: Text("Sim")),
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Não")),
        ],
      );
    }

    return Column(
      children: [
        ListTile(
          onTap: (){
             Navigator.pushNamed(context, "/create-note",
                  arguments: {"note": widget.note, "update": true});
          },
          title: Text(widget.note.name),
          subtitle: Text(Utils.converterDate(widget.note.date)),

          trailing: IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _dialog();
                  });
            },
          ),
        ),
        if (Provider.of<LocalShared>(context).previa)
          Container(
            margin: EdgeInsets.only(bottom: 8, left: 14, right: 14),
            child: widget.note.summary.length < 82 ? Text(
              "${widget.note.summary}",
              maxLines: 2,
              textAlign: TextAlign.justify,
              
            ):Text(
              Utils.resumeSummary(widget.note.summary),
              maxLines: 2,
              textAlign: TextAlign.justify,
            ),
          )
      ],
    );
  }
}
