import 'package:drift/drift.dart';

@DataClassName('BookRow')
class BooksTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get website => text()();

  IntColumn get chapter => integer()();

  TextColumn get chapterSuffix => text()();

  IntColumn get page => integer().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
