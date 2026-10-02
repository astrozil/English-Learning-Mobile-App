import 'package:drift/drift.dart';

class DictionaryTable extends Table {
  @override
  String get tableName => "words";

  TextColumn get word => text().named("word")();
  TextColumn get type => text().named("type")();
  TextColumn get defn => text().named("defn")();
}
