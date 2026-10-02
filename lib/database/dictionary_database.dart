import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:intern_project/database/dictionary_dao.dart';
import 'package:intern_project/database/dictionary_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'dictionary_database.g.dart';

@DriftDatabase(tables: [DictionaryTable], daos: [DictionaryDao])
class DictionaryDatabase extends _$DictionaryDatabase {
  DictionaryDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(join(dbFolder.path, "Dictionary.db"));

    if (!await dbFile.exists()) {
      final blob = await rootBundle.load("assets/database/Dictionary.db");
      final buffer = blob.buffer;
      await dbFile.writeAsBytes(
          buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
    }

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase(dbFile);
  });
}
