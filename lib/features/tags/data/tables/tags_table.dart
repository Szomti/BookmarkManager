import 'package:drift/drift.dart';

@DataClassName('TagRow')
class TagsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get label => text()();

  IntColumn get borderColor => integer()();

  IntColumn get backgroundColor => integer()();

  IntColumn get textColor => integer()();
}
