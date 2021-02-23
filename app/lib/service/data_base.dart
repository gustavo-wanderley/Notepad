import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/moor.dart';
part 'data_base.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max:120)();
  TextColumn get summary => text().withLength(max: 1000)();
  DateTimeColumn get date => dateTime().nullable().withDefault(Constant(DateTime.now()))();

} 

@UseMoor(tables: [Notes], daos: [NoteDao])
class DataBase extends _$DataBase{
  DataBase(): super(FlutterQueryExecutor.inDatabaseFolder(path: "db.sqlite", logStatements: true));
  int get schemaVersion => 1;
}

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<DataBase> with _$NoteDaoMixin {
  final DataBase db;

  NoteDao(this.db): super(db);

  Stream<List<Note>> watchAllNotes() => select(notes).watch();
  
  Future insertNote(Note note) => into(notes).insert(note);

  Future deleteNote(Note note) => delete(notes).delete(note);

  Future updateNote(Note note) => update(notes).replace(note);

  


}