import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:intern_project/controller/dictionary_controller.dart';
import 'package:intern_project/database/dictionary_database.dart';
import 'package:intern_project/database/dictionary_table.dart';

part 'dictionary_dao.g.dart';

@DriftAccessor(tables: [DictionaryTable])
class DictionaryDao extends DatabaseAccessor<DictionaryDatabase>
    with _$DictionaryDaoMixin {
  DictionaryDao(super.dictionaryDatabase);

  DictionaryController dictionaryController = Get.put(DictionaryController());

  Future<List<DictionaryTableData>> getAllData() async {
    return await select(dictionaryTable).get();
  }

  Stream<List<DictionaryTableData>> searchWords({required String word}) {
    return (select(dictionaryTable)..where((tbl) => tbl.word.like("$word%")))
        .watch();
  }
}
