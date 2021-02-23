import 'dart:ffi';

import 'package:app/service/data_base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteItemWidget extends StatelessWidget {
  final Note note;
  NoteItemWidget({this.note});

  final DateFormat format = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id.toString()),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.red),
          margin: EdgeInsets.all(10),
          child: ExpansionTile(
            title: Text(note.name),
            subtitle: Text("23 de fev de 2021"),
            children: [
              Text(
                "Gustavo ROdrigues Wanderey Wanderley WanderleyGustavo ROdrigues Wanderey Wanderley Wanderley",
                style: TextStyle(),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
