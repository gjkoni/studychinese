import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'db_manager.g.dart'; //这里会报错，不过没关系，执行 flutter pub run build_runner build

@DriftDatabase(
  include: {'tables.drift'}, //引入表文件，多张表只需在这里添加即可
)
class DBManager extends _$DBManager {
  DBManager() : super(_openConnection());
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'grnchinese.db')); //数据库名字
    return NativeDatabase(file);
  });
}
